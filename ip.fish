set __fish_ip_objects {"link","address","addrlabel","route","rule","neighbor","ntable","tunnel","tuntap","maddress","mroute","mrule","monitor","xfrm","netns","l2tp","fou","tcp_metrics","token","netconf"}

function __fish_ip_print_objects
  for ob in $__fish_ip_objects 
    echo $ob
  end
end

function __fish_ip_uses_object
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    for ob in $__fish_ip_objects 
      for c in $cmd 
        if [ $ob =  $c ]
          return 0
        end
      end
    end
  end
  return 1
end

function __fish_ip_last_part_is
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[-1] ]
      return 0
    end
  end
  return 1
end

complete -f -x -c ip -n '__fish_ip_last_part_is dev' -a "(__fish_print_interfaces)" --description "Network interface"

complete -f -c ip -n 'not __fish_ip_last_part_is dev' -n 'not __fish_ip_uses_object' -a "-4
-6
-color"  --description "Options"

complete -f -c ip -n 'not __fish_ip_last_part_is dev' -n 'not __fish_ip_uses_object' -a "(__fish_ip_print_objects)"  --description "Objects"

complete -f -c ip -n 'not __fish_ip_last_part_is dev' -n '__fish_ip_uses_object' -a "add
delete
show
set
list"  --description "Commands"

complete -f -c ip -n 'not __fish_ip_last_part_is dev' -n '__fish_ip_uses_object' -a "dev"  --description "Device"