## using rocm_agent_enumerator to load the ROCm archtecture info
if(NOT DEFINED ENV{RAPIDS_ROCM_ARCH})
	find_program(ROCM_AGENT_EUNMERATOR rocm_agent_enumerator PATHS "/opt/rocm/bin/" REQUIRED)
	if(ROCM_AGENT_EUNMERATOR STREQUAL "")
		message(FATAL_ERROR "rocm_agent_enumerator cannot found")
	endif()
	execute_process(COMMAND ${ROCM_AGENT_EUNMERATOR} 
		RESULT_VARIABLE rocm_agent_enumerator_return 
		OUTPUT_VARIABLE rocm_agent_enumerator_result)
	if(NOT rocm_agent_enumerator_return STREQUAL 0)
		message(FATAL_ERROR "rocm_agent_enumerator execute failed")
	endif()
	string(REPLACE "\n" ";" arch_gfx_list ${rocm_agent_enumerator_result})
	list(REMOVE_DUPLICATES arch_gfx_list)
  set(RAPIDS_ROCM_ARCH ${arch_gfx_list})
else()
  set(RAPIDS_ROCM_ARCH $ENV{RAPIDS_ROCM_ARCH})
endif()