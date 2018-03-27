
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2017.3
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z020clg400-1
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_dma:7.1\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:user:edge_detect:1.0\
xilinx.com:ip:processing_system7:5.5\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:user:tlast_gen:1.0\
xilinx.com:ip:xadc_wiz:3.3\
xilinx.com:ip:xfft:9.0\
xilinx.com:ip:xlconcat:2.1\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR_0 ]
  set FIXED_IO_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO_0 ]

  # Create ports
  set vauxn1 [ create_bd_port -dir I vauxn1 ]
  set vauxp1 [ create_bd_port -dir I vauxp1 ]

  # Create instance: axi_dma_ffti, and set properties
  set axi_dma_ffti [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_ffti ]
  set_property -dict [ list \
   CONFIG.c_addr_width {32} \
   CONFIG.c_include_mm2s {1} \
   CONFIG.c_include_s2mm {0} \
   CONFIG.c_include_s2mm_dre {0} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_m_axi_s2mm_data_width {64} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
 ] $axi_dma_ffti

  # Create instance: axi_dma_ffto, and set properties
  set axi_dma_ffto [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_ffto ]
  set_property -dict [ list \
   CONFIG.c_addr_width {32} \
   CONFIG.c_include_mm2s {0} \
   CONFIG.c_include_s2mm_dre {1} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_m_axi_s2mm_data_width {64} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
 ] $axi_dma_ffto

  # Create instance: axi_dma_xadc, and set properties
  set axi_dma_xadc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_xadc ]
  set_property -dict [ list \
   CONFIG.c_addr_width {32} \
   CONFIG.c_include_mm2s {0} \
   CONFIG.c_include_s2mm_dre {1} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_m_axi_s2mm_data_width {64} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
 ] $axi_dma_xadc

  # Create instance: axi_gpio_fft_config, and set properties
  set axi_gpio_fft_config [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_fft_config ]
  set_property -dict [ list \
   CONFIG.C_GPIO_WIDTH {16} \
 ] $axi_gpio_fft_config

  # Create instance: axi_gpio_fft_input, and set properties
  set axi_gpio_fft_input [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_fft_input ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_GPIO_WIDTH {13} \
 ] $axi_gpio_fft_input

  # Create instance: axi_gpio_fft_output, and set properties
  set axi_gpio_fft_output [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_fft_output ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_GPIO_WIDTH {14} \
 ] $axi_gpio_fft_output

  # Create instance: axi_smc, and set properties
  set axi_smc [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_smc ]
  set_property -dict [ list \
   CONFIG.NUM_SI {4} \
 ] $axi_smc

  # Create instance: edge_detect_0, and set properties
  set edge_detect_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:edge_detect:1.0 edge_detect_0 ]
  set_property -dict [ list \
   CONFIG.N {16} \
 ] $edge_detect_0

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
   CONFIG.PCW_FPGA_FCLK0_ENABLE {1} \
   CONFIG.PCW_FPGA_FCLK1_ENABLE {0} \
   CONFIG.PCW_FPGA_FCLK2_ENABLE {0} \
   CONFIG.PCW_FPGA_FCLK3_ENABLE {0} \
   CONFIG.PCW_IRQ_F2P_INTR {1} \
   CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
   CONFIG.PCW_USE_S_AXI_HP0 {1} \
   CONFIG.PCW_USE_S_AXI_HP2 {0} \
 ] $processing_system7_0

  # Create instance: ps7_0_axi_periph, and set properties
  set ps7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 ps7_0_axi_periph ]
  set_property -dict [ list \
   CONFIG.NUM_MI {7} \
 ] $ps7_0_axi_periph

  # Create instance: rst_ps7_0_50M, and set properties
  set rst_ps7_0_50M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps7_0_50M ]

  # Create instance: tlast_gen_0, and set properties
  set tlast_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:tlast_gen:1.0 tlast_gen_0 ]
  set_property -dict [ list \
   CONFIG.MAX_PKT_LENGTH {4096} \
   CONFIG.TDATA_WIDTH {16} \
 ] $tlast_gen_0

  # Create instance: tlast_gen_1, and set properties
  set tlast_gen_1 [ create_bd_cell -type ip -vlnv xilinx.com:user:tlast_gen:1.0 tlast_gen_1 ]
  set_property -dict [ list \
   CONFIG.MAX_PKT_LENGTH {8192} \
   CONFIG.TDATA_WIDTH {32} \
 ] $tlast_gen_1

  # Create instance: xadc_wiz_0, and set properties
  set xadc_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0 ]
  set_property -dict [ list \
   CONFIG.ACQUISITION_TIME {4} \
   CONFIG.ADC_CONVERSION_RATE {66} \
   CONFIG.CHANNEL_AVERAGING {None} \
   CONFIG.CHANNEL_ENABLE_VAUXP1_VAUXN1 {false} \
   CONFIG.CHANNEL_ENABLE_VAUXP2_VAUXN2 {false} \
   CONFIG.CHANNEL_ENABLE_VAUXP3_VAUXN3 {false} \
   CONFIG.CHANNEL_ENABLE_VP_VN {false} \
   CONFIG.DCLK_FREQUENCY {100} \
   CONFIG.ENABLE_AXI4STREAM {true} \
   CONFIG.ENABLE_TEMP_BUS {false} \
   CONFIG.ENABLE_VCCDDRO_ALARM {false} \
   CONFIG.ENABLE_VCCPAUX_ALARM {false} \
   CONFIG.ENABLE_VCCPINT_ALARM {false} \
   CONFIG.EXTERNAL_MUX_CHANNEL {VP_VN} \
   CONFIG.FIFO_DEPTH {7} \
   CONFIG.OT_ALARM {false} \
   CONFIG.SEQUENCER_MODE {Off} \
   CONFIG.SINGLE_CHANNEL_ACQUISITION_TIME {false} \
   CONFIG.SINGLE_CHANNEL_ENABLE_CALIBRATION {true} \
   CONFIG.SINGLE_CHANNEL_SELECTION {VAUXP1_VAUXN1} \
   CONFIG.USER_TEMP_ALARM {false} \
   CONFIG.VCCAUX_ALARM {false} \
   CONFIG.VCCINT_ALARM {false} \
   CONFIG.XADC_STARUP_SELECTION {single_channel} \
 ] $xadc_wiz_0

  # Create instance: xfft_0, and set properties
  set xfft_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.0 xfft_0 ]
  set_property -dict [ list \
   CONFIG.data_format {fixed_point} \
   CONFIG.implementation_options {automatically_select} \
   CONFIG.number_of_stages_using_block_ram_for_data_and_phase_factors {0} \
   CONFIG.output_ordering {natural_order} \
   CONFIG.phase_factor_width {16} \
   CONFIG.run_time_configurable_transform_length {false} \
   CONFIG.scaling_options {scaled} \
   CONFIG.target_clock_frequency {250} \
   CONFIG.throttle_scheme {nonrealtime} \
   CONFIG.transform_length {8192} \
 ] $xfft_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_S2MM [get_bd_intf_pins axi_dma_ffto/M_AXI_S2MM] [get_bd_intf_pins axi_smc/S00_AXI]
  connect_bd_intf_net -intf_net axi_dma_ffti_M_AXIS_MM2S [get_bd_intf_pins axi_dma_ffti/M_AXIS_MM2S] [get_bd_intf_pins xfft_0/S_AXIS_DATA]
  connect_bd_intf_net -intf_net axi_dma_ffti_M_AXI_MM2S [get_bd_intf_pins axi_dma_ffti/M_AXI_MM2S] [get_bd_intf_pins axi_smc/S01_AXI]
  connect_bd_intf_net -intf_net axi_dma_xadc_M_AXI_S2MM [get_bd_intf_pins axi_dma_xadc/M_AXI_S2MM] [get_bd_intf_pins axi_smc/S02_AXI]
  connect_bd_intf_net -intf_net axi_smc_M00_AXI [get_bd_intf_pins axi_smc/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR_0] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO_0] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins ps7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net ps7_0_axi_periph_M00_AXI [get_bd_intf_pins axi_dma_ffto/S_AXI_LITE] [get_bd_intf_pins ps7_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net ps7_0_axi_periph_M01_AXI [get_bd_intf_pins ps7_0_axi_periph/M01_AXI] [get_bd_intf_pins xadc_wiz_0/s_axi_lite]
  connect_bd_intf_net -intf_net ps7_0_axi_periph_M02_AXI [get_bd_intf_pins axi_gpio_fft_config/S_AXI] [get_bd_intf_pins ps7_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net ps7_0_axi_periph_M03_AXI [get_bd_intf_pins axi_dma_ffti/S_AXI_LITE] [get_bd_intf_pins ps7_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net ps7_0_axi_periph_M04_AXI [get_bd_intf_pins axi_dma_xadc/S_AXI_LITE] [get_bd_intf_pins ps7_0_axi_periph/M04_AXI]
  connect_bd_intf_net -intf_net ps7_0_axi_periph_M05_AXI [get_bd_intf_pins axi_gpio_fft_input/S_AXI] [get_bd_intf_pins ps7_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net ps7_0_axi_periph_M06_AXI [get_bd_intf_pins axi_gpio_fft_output/S_AXI] [get_bd_intf_pins ps7_0_axi_periph/M06_AXI]
  connect_bd_intf_net -intf_net tlast_gen_0_m_axis [get_bd_intf_pins axi_dma_xadc/S_AXIS_S2MM] [get_bd_intf_pins tlast_gen_0/m_axis]
  connect_bd_intf_net -intf_net tlast_gen_1_m_axis [get_bd_intf_pins axi_dma_ffto/S_AXIS_S2MM] [get_bd_intf_pins tlast_gen_1/m_axis]

  # Create port connections
  connect_bd_net -net axi_dma_0_s2mm_introut [get_bd_pins axi_dma_ffto/s2mm_introut] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net axi_gpio_0_gpio_io_o [get_bd_pins axi_gpio_fft_config/gpio_io_i] [get_bd_pins axi_gpio_fft_config/gpio_io_o] [get_bd_pins edge_detect_0/din] [get_bd_pins xfft_0/s_axis_config_tdata]
  connect_bd_net -net axi_gpio_2_gpio_io_o [get_bd_pins axi_gpio_fft_output/gpio_io_o] [get_bd_pins tlast_gen_1/pkt_length]
  connect_bd_net -net axi_gpio_fft_input_gpio_io_o [get_bd_pins axi_gpio_fft_input/gpio_io_o] [get_bd_pins tlast_gen_0/pkt_length]
  connect_bd_net -net edge_detect_0_edge_detected [get_bd_pins edge_detect_0/edge_detected] [get_bd_pins xfft_0/s_axis_config_tvalid]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_dma_ffti/m_axi_mm2s_aclk] [get_bd_pins axi_dma_ffti/s_axi_lite_aclk] [get_bd_pins axi_dma_ffto/m_axi_s2mm_aclk] [get_bd_pins axi_dma_ffto/s_axi_lite_aclk] [get_bd_pins axi_dma_xadc/m_axi_s2mm_aclk] [get_bd_pins axi_dma_xadc/s_axi_lite_aclk] [get_bd_pins axi_gpio_fft_config/s_axi_aclk] [get_bd_pins axi_gpio_fft_input/s_axi_aclk] [get_bd_pins axi_gpio_fft_output/s_axi_aclk] [get_bd_pins axi_smc/aclk] [get_bd_pins edge_detect_0/clk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK] [get_bd_pins ps7_0_axi_periph/ACLK] [get_bd_pins ps7_0_axi_periph/M00_ACLK] [get_bd_pins ps7_0_axi_periph/M01_ACLK] [get_bd_pins ps7_0_axi_periph/M02_ACLK] [get_bd_pins ps7_0_axi_periph/M03_ACLK] [get_bd_pins ps7_0_axi_periph/M04_ACLK] [get_bd_pins ps7_0_axi_periph/M05_ACLK] [get_bd_pins ps7_0_axi_periph/M06_ACLK] [get_bd_pins ps7_0_axi_periph/S00_ACLK] [get_bd_pins rst_ps7_0_50M/slowest_sync_clk] [get_bd_pins tlast_gen_0/aclk] [get_bd_pins tlast_gen_1/aclk] [get_bd_pins xadc_wiz_0/s_axi_aclk] [get_bd_pins xadc_wiz_0/s_axis_aclk] [get_bd_pins xfft_0/aclk]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_ps7_0_50M/ext_reset_in]
  connect_bd_net -net rst_ps7_0_50M_interconnect_aresetn [get_bd_pins ps7_0_axi_periph/ARESETN] [get_bd_pins rst_ps7_0_50M/interconnect_aresetn]
  connect_bd_net -net rst_ps7_0_50M_peripheral_aresetn [get_bd_pins axi_dma_ffti/axi_resetn] [get_bd_pins axi_dma_ffto/axi_resetn] [get_bd_pins axi_dma_xadc/axi_resetn] [get_bd_pins axi_gpio_fft_config/s_axi_aresetn] [get_bd_pins axi_gpio_fft_input/s_axi_aresetn] [get_bd_pins axi_gpio_fft_output/s_axi_aresetn] [get_bd_pins axi_smc/aresetn] [get_bd_pins ps7_0_axi_periph/M00_ARESETN] [get_bd_pins ps7_0_axi_periph/M01_ARESETN] [get_bd_pins ps7_0_axi_periph/M02_ARESETN] [get_bd_pins ps7_0_axi_periph/M03_ARESETN] [get_bd_pins ps7_0_axi_periph/M04_ARESETN] [get_bd_pins ps7_0_axi_periph/M05_ARESETN] [get_bd_pins ps7_0_axi_periph/M06_ARESETN] [get_bd_pins ps7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_ps7_0_50M/peripheral_aresetn] [get_bd_pins tlast_gen_0/resetn] [get_bd_pins tlast_gen_1/resetn] [get_bd_pins xadc_wiz_0/s_axi_aresetn]
  connect_bd_net -net tlast_gen_0_s_axis_tready [get_bd_pins tlast_gen_0/s_axis_tready] [get_bd_pins xadc_wiz_0/m_axis_tready]
  connect_bd_net -net tlast_gen_1_s_axis_tready [get_bd_pins tlast_gen_1/s_axis_tready] [get_bd_pins xfft_0/m_axis_data_tready]
  connect_bd_net -net vauxn1_1 [get_bd_ports vauxn1] [get_bd_pins xadc_wiz_0/vauxn1]
  connect_bd_net -net vauxp1_1 [get_bd_ports vauxp1] [get_bd_pins xadc_wiz_0/vauxp1]
  connect_bd_net -net xadc_wiz_0_m_axis_tdata [get_bd_pins tlast_gen_0/s_axis_tdata] [get_bd_pins xadc_wiz_0/m_axis_tdata]
  connect_bd_net -net xadc_wiz_0_m_axis_tvalid [get_bd_pins tlast_gen_0/s_axis_tvalid] [get_bd_pins xadc_wiz_0/m_axis_tvalid]
  connect_bd_net -net xfft_0_m_axis_data_tdata [get_bd_pins tlast_gen_1/s_axis_tdata] [get_bd_pins xfft_0/m_axis_data_tdata]
  connect_bd_net -net xfft_0_m_axis_data_tvalid [get_bd_pins tlast_gen_1/s_axis_tvalid] [get_bd_pins xfft_0/m_axis_data_tvalid]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins processing_system7_0/IRQ_F2P] [get_bd_pins xlconcat_0/dout]

  # Create address segments
  create_bd_addr_seg -range 0x20000000 -offset 0x00000000 [get_bd_addr_spaces axi_dma_ffti/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x00000000 [get_bd_addr_spaces axi_dma_ffto/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x00000000 [get_bd_addr_spaces axi_dma_xadc/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x00010000 -offset 0x40400000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_dma_ffto/S_AXI_LITE/Reg] SEG_axi_dma_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40410000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_dma_ffti/S_AXI_LITE/Reg] SEG_axi_dma_ffti_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40420000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_dma_xadc/S_AXI_LITE/Reg] SEG_axi_dma_xadc_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_fft_config/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41210000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_fft_input/S_AXI/Reg] SEG_axi_gpio_1_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41220000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_fft_output/S_AXI/Reg] SEG_axi_gpio_2_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs xadc_wiz_0/s_axi_lite/Reg] SEG_xadc_wiz_0_Reg


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


