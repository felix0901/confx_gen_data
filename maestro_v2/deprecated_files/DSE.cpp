
#include <memory>

#include "DSE_hardware_modules.hpp"

namespace maestro {
	namespace DSE {
		std::shared_ptr<DSE::HardwareModule> ConstructAccelerator(int num_dse_pes, int l2_sram_byte_size, int l1_sram_byte_size, int noc_bw = 16, int vector_width = 1) {
			std::shared_ptr<DSE::HardwareModule> accelerator = std::make_shared<DSE::HardwareModule>();

			/* Processing Element */
			std::shared_ptr<DSE::HardwareModule> pe_array = std::make_shared<DSE::HardwareModule>();
			for(int peID = 0; peID < num_dse_pes; peID++) {
				std::shared_ptr<DSE::HardwareModule> pe = std::make_shared<DSE::HardwareModule>();
				std::shared_ptr<DSE::HardwareModule> mac = std::make_shared<DSE::MAC>(4470.9014, 1.2223, vector_width);
				std::shared_ptr<DSE::HardwareModule> l1_sram = std::make_shared<DSE::SRAM>(4505.1889, 0.2208, 64, l1_sram_byte_size);

				pe->AddSubmodule(mac);
				pe->AddSubmodule(l1_sram);

				pe_array->AddSubmodule(pe);
			}

			/* L2 Buffer */
			std::shared_ptr<DSE::HardwareModule> l2_sram = std::make_shared<DSE::SRAM>(4505.1889, 0.2208, 64, l2_sram_byte_size);

			/* NoC */
			std::shared_ptr<DSE::HardwareModule> noc = std::make_shared<DSE::HardwareModule>();
			std::shared_ptr<DSE::HardwareModule> bus = std::make_shared<DSE::Bus>(101.7938, 0.8, num_dse_pes, noc_bw);
			std::shared_ptr<DSE::HardwareModule> arbiter = std::make_shared<DSE::MatrixArbiter>(395.473, 0.34, num_dse_pes);

			noc->AddSubmodule(bus);
			noc->AddSubmodule(arbiter);


			accelerator->AddSubmodule(pe_array);
			accelerator->AddSubmodule(noc);
			accelerator->AddSubmodule(l2_sram);

			return accelerator;
		}


	};
};
