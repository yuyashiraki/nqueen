all:
	iverilog alu.v decoder.v imem.v jmpsel.v memory.v pc.v register.v selector.v top.v top_test.v

clean:
	rm -f a.out top_test.vcd
