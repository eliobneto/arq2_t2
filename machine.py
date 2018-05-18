import m5
import sys
from m5.objects import *
from caches import *
from optparse import OptionParser

parser = OptionParser()

parser.add_option("-c", "--cmd", default="", help="The binary to run in syscall emulation mode.")
parser.add_option("-o", "--options", default="", help="""The options to pass to the binary, use " " around the entire string""")
parser.add_option("-i", "--input", default="", help="Read stdin from a file.")
parser.add_option("-b", "--branch", default="", metavar="FILE", help="The branch prediction option to pass to execute") 

(option, args) = parser.parse_args()

if not option.cmd:
	print ("Invalid binary")
	sys.exit(1)

if not option.branch:
	print ("Parameter not specified")
	sys.exit(1)
if option.branch == "local":
	branch = LocalBP()
elif option.branch == "tournament":
	branch = TournamentBP()
elif option.branch == "bimode":
	branch = BiModeBP()
elif option.branch == "ltage":
	branch = LTAGE()
else:
	print ("Parameter invalid")
	sys.exit(1)

system = System()

system.clk_domain = SrcClockDomain()
system.clk_domain.clock = '2GHz'
system.clk_domain.voltage_domain = VoltageDomain()

system.mem_mode = 'timing'
system.mem_ranges = [AddrRange('512MB')]

system.cpu = DerivO3CPU()

system.cpu.icache = L1ICache()
system.cpu.dcache = L1DCache()

system.cpu.icache.connectCPU(system.cpu)
system.cpu.dcache.connectCPU(system.cpu)

system.l2bus = L2XBar()

system.cpu.icache.connectBus(system.l2bus)
system.cpu.dcache.connectBus(system.l2bus)

system.l2cache = L2Cache()
system.l2cache.connectCPUSideBus(system.l2bus)

system.membus = SystemXBar()

system.l2cache.connectMemSideBus(system.membus)

system.cpu.createInterruptController()
system.cpu.interrupts[0].pio = system.membus.master
system.cpu.interrupts[0].int_master = system.membus.slave
system.cpu.interrupts[0].int_slave = system.membus.master

system.system_port = system.membus.slave

system.mem_ctrl = DDR3_1600_8x8()
system.mem_ctrl.range = system.mem_ranges[0]
system.mem_ctrl.port = system.membus.master

process = Process()
process.cmd = [option.cmd] + option.options.split(" ")
system.cpu.workload = process
system.cpu.createThreads()

root = Root(full_system = False, system = system)
m5.instantiate()

print("Beginning simulation!")
exit_event = m5.simulate()

print('Exiting @ tick {} because {}'.format(m5.curTick(), exit_event.getCause()))
