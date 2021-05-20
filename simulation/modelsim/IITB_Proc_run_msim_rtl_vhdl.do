transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/raja/Desktop/IITB-Proc/Testbench.vhdl}
vcom -93 -work work {/home/raja/Desktop/IITB-Proc/DUT.vhdl}
vcom -93 -work work {/home/raja/Desktop/IITB-Proc/TwoByOneMux.vhd}
vcom -93 -work work {/home/raja/Desktop/IITB-Proc/FourByOneMux.vhd}
vcom -93 -work work {/home/raja/Desktop/IITB-Proc/SixteenbitFullAdd.vhd}
vcom -93 -work work {/home/raja/Desktop/IITB-Proc/register_file.vhd}
vcom -93 -work work {/home/raja/Desktop/IITB-Proc/OnebitHalfAdd.vhd}
vcom -93 -work work {/home/raja/Desktop/IITB-Proc/OnebitFullAdd.vhd}
vcom -93 -work work {/home/raja/Desktop/IITB-Proc/muxQ41.vhd}
vcom -93 -work work {/home/raja/Desktop/IITB-Proc/memory_asyncread.vhd}
vcom -93 -work work {/home/raja/Desktop/IITB-Proc/IITB_Proc.vhd}
vcom -93 -work work {/home/raja/Desktop/IITB-Proc/alu.vhd}

vcom -93 -work work {/home/raja/Desktop/IITB-Proc/Testbench.vhdl}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  Testbench

add wave *
view structure
view signals
run -all
