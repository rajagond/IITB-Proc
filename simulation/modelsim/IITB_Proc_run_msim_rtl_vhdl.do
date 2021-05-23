transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/raja/Desktop/IITB_Proc/memory_asyncread.vhd}
vcom -93 -work work {/home/raja/Desktop/IITB_Proc/testbench.vhd}
vcom -93 -work work {/home/raja/Desktop/IITB_Proc/OnebitFullAdd.vhd}
vcom -93 -work work {/home/raja/Desktop/IITB_Proc/EightbitFullAdd.vhd}
vcom -93 -work work {/home/raja/Desktop/IITB_Proc/register_file.vhd}
vcom -93 -work work {/home/raja/Desktop/IITB_Proc/SixteenbitFullAdd.vhd}
vcom -93 -work work {/home/raja/Desktop/IITB_Proc/alu.vhd}
vcom -93 -work work {/home/raja/Desktop/IITB_Proc/muxQ41.vhd}
vcom -93 -work work {/home/raja/Desktop/IITB_Proc/IITB_Proc.vhd}

vcom -93 -work work {/home/raja/Desktop/IITB_Proc/testbench.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
