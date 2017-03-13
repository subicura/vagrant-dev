$project_name = 'subicura'
$host_names = ["asset.#{$project_name}.local.dev"]
$private_ip = '11.11.11.11'
$source_folder = 'src'
$source_owner = 'www-data'
$source_group = 'www-data'
$bindfs_folder = '/var/www'

# cpu & memory - default all cpu, 1/4 memory
host = RbConfig::CONFIG['host_os']
if host =~ /darwin/
  $vm_cpus = `sysctl -n hw.ncpu`.to_i
  $vm_memory = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
elsif host =~ /linux/
  $vm_cpus = `nproc`.to_i
  $vm_memory = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
else # sorry Windows folks, I can't help you
  $vm_cpus = 2
  $vm_memory = 2048
end
