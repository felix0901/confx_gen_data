'''
Working version for both GEMM and nonGEMM
'''
import random
import os, sys
import argparse
import torch
from collections import deque
import matplotlib.pyplot as plt
script_dir = os.path.dirname(__file__)
module_path = os.path.abspath(os.path.join(script_dir, '../../'))
if module_path not in sys.path:
    sys.path.insert(0,module_path)
import src.ConfX.ga_confx as ga
from src.ConfX.env_confx import MaestroEnvironment
import pickle
from src.ConfX.rl_confx import Agent
import pandas as pd
import copy
from datetime import datetime
from src.utils.get_action_space import *
import glob
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")



def policy_graident(n_episodes=100000, max_t=1000, print_every=10, outfile="out.plt", chkpt_file="trial.plt", eps=0,temperature=1):

    best_score = -2**20
    scores_window = deque(maxlen=print_every)
    scores = []
    episodes = 0
    has_succeed_history = False
    for i_episode in range(1 + episodes, n_episodes + episodes + 1):
        if (i_episode+1) %100 ==0  and has_succeed_history:
            eps /= 1.2
            temperature /=1.01
            temperature = max(temperature,1)
            agent.ajust_lr(ratio=0.8, min_lr=1e-6)

        score = 0
        env.shuffle_model()
        state, infos = env.reset()
        for t in range(max_t):
            action, log_prob = agent.act(state, infos, eps,temperature)
            next_state, reward, done, infos, sig, impt= env.step(action)
            agent.step(state, action, log_prob, reward, next_state, done, sig, impt, infos)
            state = next_state
            score += reward
            if done:
                break
        scores_window.append(score)
        scores.append(score)
        if np.mean(scores_window) > best_score:
            best_score = np.mean(scores_window)
        agent_chkpt = agent.get_chkpt()
        env_chkpt = env.get_chkpt()
        others_chkpt =  {
                 "scores": scores,
                 "best_score": best_score,
                 "scores_window":scores_window,
                 "episodes":i_episode}
        chkpt = {"agent_chkpt": agent_chkpt,
                 "env_chkpt": env_chkpt,
                 "others_chkpt": others_chkpt}
        if i_episode % 5 == 0:
            env.save_chkpt(chkpt_file)
            torch.save(chkpt, outfile)

        if infos["succeed"]:
            has_succeed_history = True
            print("Episode {}: succeed".format(i_episode))
        else:
            print("Episode {}: finding".format(i_episode))




    return scores

def get_probe_int(sol):
    sol = np.array(sol)
    sol = sol.flatten()
    parms = {"{}".format(i): e for i, e in enumerate(sol)}
    return parms

def get_probe(sol):
    sol = np.log2(sol)
    sol = sol.flatten()
    parms = {"{}".format(i): e for i, e in enumerate(sol)}
    return parms


def genetic_search(best_sol, best_reward, action_bound, action_bottom, num_layers=None, num_generations=100, num_pop = 20):
    reward_record_g = []
    best_rewards_g = []
    best_sol_g = best_sol
    best_reward_g = best_reward
    num_layers = num_layers if num_layers else len(model_defs)


    num_generations = num_generations
    num_population = num_pop
    num_parents_init = 8

    new_population = np.ones((num_population, num_layers, 2)) * best_sol

    count = 0

    fitness = np.ones((num_population, 2), float) * best_reward

    # print("Cases {}: reward: {}".format(0, best_reward_g))
    count_non_valid = 0
    for g in range(num_generations):
        gen_best = -float("Inf")
        num_parents = max(1, min(num_parents_init, num_population - count_non_valid))
        count_non_valid = 0

        parents = ga.select_parents(new_population, fitness,
                                    num_parents, num_layers)


        ga.mutation(parents, new_population, action_bound, action_bottom, env, fitness, range_alpha=ratio)
        ga.self_crossover(new_population, eps=0.2)
        new_population[0, :] = parents[0]

        for i in range(num_population):
            reward, total_constraint = env.exterior_search(new_population[i])
            if total_constraint > env.constraint_value:
                reward = float("-Inf")
                count_non_valid += 1
            gen_best = max(gen_best, reward)
            fitness[i] = np.array([reward, total_constraint])
        max_idx = np.argmax(fitness[:, 0])
        reward_record_g.append(copy.deepcopy(np.nanmean(fitness[fitness[:, 0] > float("-Inf")], axis=0)))
        if best_reward_g[0] < fitness[max_idx][0]:
            best_reward_g = copy.deepcopy(fitness[max_idx])
            best_sol_g = copy.deepcopy(new_population[max_idx])
        best_rewards_g.append(best_reward_g)
        chkpt = {
            "best_sol_g": best_sol_g,
            "best_rewards_g": best_rewards_g,
            "reward_record_g": reward_record_g,
            "num_population_g": num_population,
            "num_generations_g": num_generations,
            "num_parents_g": num_parents
        }

        print(f"Gen {g+1}:  Best reward: {best_reward_g[0]:.4e}, Used Constraint: {best_reward_g[1]/env.constraint_value * 100:.1f}%")

    return chkpt

def test(sol, env):
    reward, total_constraint = env.exterior_search(sol)
    return reward, total_constraint

def check_sol(sol):
    reward = env.exterior_search(sol)
    print("Reward: {}".format(reward))
    return reward

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--filename', type=str, default="try", help='output directiory')
    parser.add_argument('--outdir', type=str, default="outdir", help='output directiory')
    parser.add_argument('--model', type=str, default="mobilenet_v2", help='The experimenting model.')
    parser.add_argument('--fitness', type=str, default="latency", help='The objective.')
    parser.add_argument('--cstr', type=str, default="area", help='The constraint.')
    parser.add_argument('--mul', type=float, default=0.5, help='The resource ratio, the design is allowed to use.')
    parser.add_argument('--epochs', type=int, default=500, help='pickle file name')
    parser.add_argument('--gpu', default=0, type=int, help='which gpu')
    parser.add_argument('--df', default="dla", type=str, help='The dataflow strategy.')
    parser.add_argument('--alg', type=str, default="RL_GA", help='Please choose from [RL, RL_GA]', choices=["RL", "RL_GA"])
    parser.add_argument('--n_act', type=int, default=2, help='The number of action to make for each layer', choices=[1, 2, 3])
    opt = parser.parse_args()
    ratio = opt.mul
    device = 'cuda:' + str(opt.gpu) if torch.cuda.is_available() else 'cpu'

    if opt.mul == 0.5:
        platform = 'cloud'
    if opt.mul == 0.3:
        platform = 'edge'
    if opt.mul == 0.1:
        platform = 'IoT'
    if opt.mul == 0.05:
        platform = 'IoTx'
    dir_name =f'outputs/{opt.model}_{opt.df}_{platform}'
    os.makedirs(dir_name, exist_ok=True)
    filename = os.path.join(dir_name, opt.filename)
    now = datetime.now()
    now_date = "{}".format(now.date())
    now_time = "{}".format(now.time())
    is_discrete = True
    n_acts = opt.n_act
    dis_or_cont = "D" if is_discrete else "C"
    alg = opt.alg
    outdir = opt.outdir
    outdir = os.path.join("../../", outdir)
    exp_name = "{}_F-{}_C-{}_Mul-{}_DF-{}_{}_{}".format(opt.model, opt.fitness, opt.cstr, opt.mul, opt.df, alg,
                                                dis_or_cont)

    outdir_exp = os.path.join(outdir, exp_name)
    os.makedirs(outdir, exist_ok=True)
    os.makedirs(outdir_exp, exist_ok=True)
    chkpt_file_t =  os.path.join(outdir_exp,"{}".format("result"))



    outfile = chkpt_file_t + "_o.plt"
    chkpt_file =  chkpt_file_t + "_c.plt"
    img_file = chkpt_file_t + ".png"
    log_file = chkpt_file_t + ".csv"



    action_space, action_bound, action_bottom = get_action_space()
    m_file_path = "../../data/model/"
    m_file = os.path.join(m_file_path, opt.model + ".csv")
    df = pd.read_csv(m_file)
    model_defs = df.to_numpy()
    _,dim_size = model_defs.shape

    using_ga = True if opt.alg =="RL_GA" else False
    epoch_rl = opt.epochs * 2 // 3 if using_ga else opt.epochs
    epoch_ga = opt.epochs - epoch_rl
    try:
        # ============================Start Env============================================================================================

        agent = Agent(dim_size=dim_size, resource_size=2, n_action_steps = 2, action_size=12, seed=random.randint(0, 2**63))

        env = MaestroEnvironment(model_defs=model_defs,dim_size=dim_size, resource_size=2,n_action_steps=2, dataflow=opt.df)
        state = env.reset()
        env.set_fitness(opt.fitness)
        env.set_constraint(opt.cstr)
        constraint_temp = [env.get_ref_constraint([action_bound[0], action_bound[1]]),
                           env.get_ref_constraint([action_bottom[0], action_bottom[1]]),
                           env.get_ref_constraint([action_bound[0], action_bottom[1]]),
                           env.get_ref_constraint([action_bottom[0], action_bound[1]])]
        max_constraint, min_constraint = max(constraint_temp), min(constraint_temp)
        print("Max constraint: {}".format(max_constraint))
        print("Min constraint: {}".format(min_constraint))
        set_constraint = min_constraint + (max_constraint - min_constraint) * ratio

        env.set_constraint_value(max_constraint, min_constraint, set_constraint)
        print("Set constraint: {}".format(set_constraint))
        # ========================================================================================================================
        #===data collection==========
        # data = []
        # for i in range(int(1e7)):
        #     reward, total_constraint, sol = env.get_one_sample(action_space=action_space)
        #     if reward is None:
        #         latency = 0
        #     else:
        #         if total_constraint > set_constraint:
        #             latency = 0
        #         else:
        #             latency = -reward
        #     print(latency)
        #     data.append([latency,total_constraint,set_constraint, *np.array(sol).flatten()])
        #     np_data = np.array(data)
        #     if i%100 == 0:
        #         columns = ['latency', 'area_cost', 'area_constraint', *np.array([[f'L_{i+1}_PE',f'L_{i+1}_Buf'] for i in range(len(model_defs))]).flatten().tolist()]
        #         df = pd.DataFrame(np_data, columns=columns)
        #         df.to_csv(f'{filename}_cstr.csv')
        #         df2 = df.drop(columns=[ 'area_cost', 'area_constraint'])
        #         df2.to_csv(f'{filename}.csv')
        #============================

        #=====testing=======
        sol = [[128, 5], [32, 10], [48, 1], [2, 1], [24, 4], [4, 7], [2, 12], [48, 2], [24, 4], [1, 10], [64, 10], [64, 1], [64, 2], [32, 11], [48, 1], [4, 5], [32, 2], [16, 11], [4, 6], [8, 7], [4, 11], [4, 1], [64, 7], [4, 9], [64, 8], [1, 10], [32, 9], [12, 8], [48, 12], [32, 3], [12, 3], [2, 11], [48, 2], [12, 11], [64, 5], [96, 6], [96, 2], [8, 3], [8, 3], [12, 1], [32, 10], [4, 12], [8, 10], [96, 8], [2, 3], [2, 6], [96, 7], [24, 5], [2, 3], [128, 11], [48, 9], [4, 9]]
        reward, constraint = test(sol, env)

        #===testing from csv=====
        results = pd.read_csv('../../others/1_cstr.csv').to_numpy()
        sol = []
        result = results[0]
        latency = result[1]
        use_constraint_csv = result[2]
        set_constraint_csv = result[3]
        for i in range(4, len(result), 2):
            sol.append([result[i], result[i+1]])

        reward, constraint = test(sol, env)
        print(latency, -reward)
        print(use_constraint_csv, constraint)
        print(set_constraint_csv, set_constraint)
        #=====================

    finally:
        for f in glob.glob("*.m"):
            os.remove(f)
        # for f in glob.glob("*.csv"):
        #     if f != f'{filename}.csv':
        #         os.remove(f)




