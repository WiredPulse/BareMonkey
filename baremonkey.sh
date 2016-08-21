#!/usr/bin/env bash

##############################################################################
#  Script: Bare Monkey
# Version: 1.0
#  Author: WiredPulse
#   Legal: Script provided "AS IS" without warranties or guarantees of any
#          kind.  USE AT YOUR OWN RISK.  Public domain, no rights reserved.
##############################################################################


# This script runs Windows and Linux plug-ins available in Volatility. For specifics, run volatality --info in your terminal.
#
#                   	  
echo "                                          "
echo "                         ___	        "	
echo "                        / _,\	        "
echo "                        \_\	        "
echo "             ,,,,    _,_)  #      /)	"
echo "            (= =)D__/    __/     //	"
echo "           C/^__)/     _(    ___//	"
echo "             \_,/  -.   '-._/,--'	        "
echo "       _\\_,  /           -//.	        "
echo "        \_ \_/  -,._ _     ) )	        "
echo "          \/    /    )    / /	        "
echo "          \-__,/    (    ( (	        "
echo "                     \.__,-)\_	        "
echo "                      )\_ / -(	        "
echo "                     / -(////	        "
echo "                    ////	                "
echo "                                          "
echo " *********************************************************************"
echo "  This script will do the following against your memory capture: "
echo "  - Run all possible plug-ins for the specified OS and output to TXT"
echo "  - Delete output TXT that contain no data "
echo "  - Create a tarball "
echo "  - Create a hash "
echo "  The benefits are: "
echo "  - Volatility is not needed after output "
echo "  - Analyze output on any system with a text editor "
echo "  - Portable "
echo "                     *Message will scroll in 10 seconds* "      
echo " *********************************************************************"
echo " "
sleep 1
read -p "Enter the full path to the location of your memory capture: " NEW_FILE
echo " Your memory capture is here: $NEW_FILE "
echo "                     *Message will scroll in 5 seconds* "   
sleep 1
OPERATING_SYSTEM=
while [ -z "$OPERATING_SYSTEM" ] ;
do
    echo
    echo
    echo "  ***************************************"
    echo "  Please select the operating system the"
    echo "  memory capture came from"
    echo "  1 - Win8"
    echo "  2 - Win7"
    echo "  3 - Vista"
    echo "  4 - WinXP"
    echo "  5 - Server 2008"
    echo "  6 - Server 2012"
    echo "    Select 1, 2, 3, 4, 5, or 6 :" \n
    echo "  ***************************************"
    printf "    Enter Selection> "; read OPERATING_SYSTEM
    if [ "$OPERATING_SYSTEM" -eq 1 ] ; then
	echo
	echo " You have selected 1 - Win8"
	echo
    elif [ "$OPERATING_SYSTEM" -eq 2 ] ; then 
	echo
	echo " You have selected 2 - Win7"
	echo
    elif [ "$OPERATING_SYSTEM" -eq 3 ] ; then
	echo
	echo " You have selected 3 - WinXP"
	echo
    elif [ "$OPERATING_SYSTEM" -eq 4 ] ; then
	echo
	echo " You have selected 4 - Vista "
	echo
    elif [ "$OPERATING_SYSTEM" -eq 5 ] ; then
	echo
	echo " You have selected 5 - Server 2008"
	echo
    elif [ "$OPERATING_SYSTEM" -eq 6 ] ; then
	echo
	echo " You have selected 6 - Server 2012"
	echo
    else
	echo 
	echo " *****ERROR*****ERROR*******************"
	echo " Please select 1, 2, 3, 4, 5, or 6 "
	echo " ---------------------------------------"
	OPERATING_SYSTEM=
    fi
	    if [ "$OPERATING_SYSTEM" -eq 1 ] ; then
	    	WIN8_FLAVOR=('Win8SP0x64' 'Win8SP0x86' 'Win8SP1x64' 'Win8SP1x86')
	    	WIN8_OS=
	        while [ -z "$WIN8_OS" ] ;
	        do
			echo
	        	echo
    	        	echo "  ***************************************"
   	       		echo "  Please select the CPU version of which"
    	       	 	echo "  the memory capture came from"
    	        	echo "  1 - Win8SP0x64"
    	        	echo "  2 - Win8SP0x86"
   	        	echo "  3 - Win8SP1x64"
    	        	echo "  4 - Win8SP1x86"
   	        	echo "    Select 1, 2, 3, or 4 :" \n
   	        	echo "  ***************************************"
   	        	printf "    Enter Selection> "; read WIN8_OS
	        	echo " You have selected 1 - ${WIN8_FLAVOR[WIN8_OS-1]}"
	        	echo
                if [ "$WIN8_OS" -eq 1 ] ; then
			mkdir ./vol-output
			mkdir ./vol-output/image_id
			mkdir ./vol-output/processes_dll
			mkdir ./vol-output/process_memory
			mkdir ./vol-output/kernel_mem_modules
			mkdir ./vol-output/networking
			mkdir ./vol-output/registry
			mkdir ./vol-output/malware_rootkits
			mkdir ./vol-output/file_system
			mkdir ./vol-output/misc
			echo "###################################################### "
			echo "# 1 of 9 - Now outputting image identification files # "
			echo "###################################################### "
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR imageinfo >> ./vol-output/image_id/imageinfo.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR kdbgscan >> ./vol-output/image_id/kdbgscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR kpcrscan >> ./vol-output/image_id/kpcrscan.txt 2>/dev/null
			echo "#################################################### "
			echo "# 2 of 9 - Now outputting processess and dll files # "
			echo "#################################################### "
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR pslist >> ./vol-output/processes_dll/pslist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR pstree >> ./vol-output/processes_dll/pstree.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR psscan >> ./vol-output/processes_dll/psscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR psdispscan >> ./vol-output/processes_dll/psdispscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR dlllist >> ./vol-output/processes_dll/dlllist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR dlldump >> ./vol-output/processes_dll/dlldump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR handles >> ./vol-output/processes_dll/handles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR getsids >> ./vol-output/processes_dll/getsids.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR cmdscan >> ./vol-output/processes_dll/cmdscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR consoles >> ./vol-output/processes_dll/consoles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR privs >> ./vol-output/processes_dll/privs.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR envars >> ./vol-output/processes_dll/envars.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR verinfo >> ./vol-output/processes_dll/verinfo.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR handles >> ./vol-output/processes_dll/handles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR enumfunc >> ./vol-output/processes_dll/enumfunc.txt 2>/dev/null
			echo "################################################ "
			echo "# 3 of 9 - Now outputting process memory files # "
			echo "################################################ "
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR memmap >> ./vol-output/process_memory/memmap.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR memdump >> ./vol-output/process_memory/memdump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR vadinfo >> ./vol-output/process_memory/vadinfo.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR vadwalk >> ./vol-output/process_memory/vadwalk.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR vadtree >> ./vol-output/process_memory/vadtree.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR iehistory >> ./vol-output/process_memory/iehistory.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR procmemdump >> ./vol-output/process_memory/procmemdump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR procexedump >> ./vol-output/process_memory/procexedump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR vaddump >> ./vol-output/process_memory/vaddump.txt 2>/dev/null
			echo "######################################################### "
			echo "# 4 of 9 - Now outputting kernel memory & objects files # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR modules >> ./vol-output/kernel_mem_modules/modules.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR modscan >> ./vol-output/kernel_mem_modules/modscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR moddump >> ./vol-output/kernel_mem_modules/moddump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR ssdt >> ./vol-output/kernel_mem_modules/ssdt.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR driverscan >> ./vol-output/kernel_mem_modules/driverscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR filescan >> ./vol-output/kernel_mem_modules/filescan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR mutantscan >> ./vol-output/kernel_mem_modules/mutantscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR symlinkscan >> ./vol-output/kernel_mem_modules/symlinkscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR thrdscan >> ./vol-output/kernel_mem_modules/thrdscan.txt 2>/dev/null
			echo "############################################ "
			echo "# 5 of 9 - Now outputting networking files # "
			echo "############################################ "
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR netscan >> ./vol-output/networking/netscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR connections >> ./vol-output/networking/connections.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR connscan >> ./vol-output/networking/connscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR sockets >> ./vol-output/networking/sockets.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR sockscan >> ./vol-output/networking/sockscan.txt 2>/dev/null
			echo "########################################## "
			echo "# 6 of 9 - Now outputting registry files # "
			echo "########################################## "
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR hivescan >> ./vol-output/registry/hivescan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR hivelist >> ./vol-output/registry/hivelist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR printkey >> ./vol-output/registry/printkey.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR lsadump >> ./vol-output/registry/lsadump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR hivedump >> ./vol-output/registry/hivedump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR hashdump >> ./vol-output/registry/hashdump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR userassist >> ./vol-output/registry/userassist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR shimcache >> ./vol-output/registry/shimcache.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR shellbags >> ./vol-output/registry/shellbags.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR getservicesids >> ./vol-output/registry/getservicesids.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR auditpol >> ./vol-output/registry/auditpol.txt 2>/dev/null
			echo "################################################## "
			echo "# 7 of 9 - Now outputting malware/rootkits files # "
			echo "################################################## "
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR malfind >> ./vol-output/malware_rootkits/malfind.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR yarascan>> ./vol-output/malware_rootkits/yarascan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR svcscan >> ./vol-output/malware_rootkits/svcscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR ldrmodules >> ./vol-output/malware_rootkits/ldrmodules.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR impscan >> ./vol-output/malware_rootkits/impscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR apihooks >> ./vol-output/malware_rootkits/apihooks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR idt >> ./vol-output/malware_rootkits/idt.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR gdt >> ./vol-output/malware_rootkits/gdt.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR threads >> ./vol-output/malware_rootkits/threads.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR callbacks >> ./vol-output/malware_rootkits/callbacks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR driverirp >> ./vol-output/malware_rootkits/driverirp.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR devicetree >> ./vol-output/malware_rootkits/devicetree.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR psxview >> ./vol-output/malware_rootkits/psxview.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR timers >> ./vol-output/malware_rootkits/timers.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR strings >> ./vol-output/malware_rootkits/strings.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR volshell >> ./vol-output/malware_rootkits/volshell.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR bioskbd >> ./vol-output/malware_rootkits/bioskbd.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR patcher >> ./vol-output/malware_rootkits/patcher.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR pagecheck >> ./vol-output/malware_rootkits/pagecheck.txt 2>/dev/null
			echo "############################################# "
			echo "# 8 of 9 - Now outputting file system files # "
			echo "############################################# "
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR mbrparser >> ./vol-output/file_system/master_boot_record.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR mftparser >> ./vol-output/file_system/master_file_table.txt 2>/dev/null
			echo "####################################### "
			echo "# 9 of 9 - Now outputting misc. files # "
			echo "####################################### "
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR notepad >> ./vol-output/misc/notepad.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR screenshot >> ./vol-output/misc/screenshot.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR sessions >> ./vol-output/misc/sessions.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR multiscan >> ./vol-output/misc/multiscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR messagehooks >> ./vol-output/misc/messagehooks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR dumpfiles >> ./vol-output/misc/dumpfiles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR dumpcerts >> ./vol-output/misc/dumpcerts.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR evtlogs >> ./vol-output/misc/evtlogs.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR clipboard >> ./vol-output/misc/clipboard.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR eventhooks >> ./vol-output/misc/eventhooks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN8_FLAVOR gahti >> ./vol-output/misc/gahti.txt 2>/dev/null
	# Looks for empty files that were created from this script and deletes them.
			find ./vol-output -empty -type f -delete
			tar -cf $WIN8_FLAVOR.tar ./vol-output
			rm -rf ./vol-output
			type gzip > /dev/null
			if [ $? -eq 0 ] ; then gzip $WIN8_FLAVOR.tar
   			else compress $WIN8_FLAVOR.tar
			fi
			md5sum ./$WIN8_FLAVOR.tar.gz > Hash:$WIN8_FLAVOR-memory_cap
#Closing Messages
echo
echo " ############################################################################################"
echo " There is a new compressed file placed on your system."
if [ -f ./$WIN8_FLAVOR.tar.gz ] ; then 
echo " The tarball and hash is in the current working directory and is called $WIN8_FLAVOR.tar.gz"
else 
echo " The file is in the current working directory and is called $WIN8_FLAVOR.tar.gz"
fi
	
		fi
		done
		fi
		if [ "$OPERATING_SYSTEM" -eq 2 ] ; then
	    	WIN7_FLAVOR=('Win7SP0x64' 'Win7SP0x86' 'Win7SP1x64' 'Win7SP1x86')
	    	WIN7_OS=
	        while [ -z "$WIN7_OS" ] ;
	        do
			echo
	        	echo
    	        	echo "  ***************************************"
   	       		echo "  Please select the CPU version of which"
    	       	 	echo "  the memory capture came from"
    	        	echo "  1 - Win7SP0x64"
    	        	echo "  2 - Win7SP0x86"
   	        	echo "  3 - Win7SP1x64"
    	        	echo "  4 - Win7SP1x86"
   	        	echo "    Select 1, 2, 3, or 4 :" \n
   	        	echo "  ***************************************"
   	        	printf "    Enter Selection> "; read WIN7_OS
	        	echo " You have selected 1 - ${WIN7_FLAVOR[WIN7_OS-1]}"
	        	echo
                if [ "$WIN7_OS" -eq 1 ] ; then
			mkdir ./vol-output
			mkdir ./vol-output/image_id
			mkdir ./vol-output/processes_dll
			mkdir ./vol-output/process_memory
			mkdir ./vol-output/kernel_mem_modules
			mkdir ./vol-output/networking
			mkdir ./vol-output/registry
			mkdir ./vol-output/malware_rootkits
			mkdir ./vol-output/file_system
			mkdir ./vol-output/misc
			echo "###################################################### "
			echo "# 1 of 9 - Now outputting image identification files # "
			echo "###################################################### "
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR imageinfo >> ./vol-output/image_id/imageinfo.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR kdbgscan >> ./vol-output/image_id/kdbgscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR kpcrscan >> ./vol-output/image_id/kpcrscan.txt 2>/dev/null
			echo "#################################################### "
			echo "# 2 of 9 - Now outputting processess and dll files # "
			echo "#################################################### "
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR pslist >> ./vol-output/processes_dll/pslist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR pstree >> ./vol-output/processes_dll/pstree.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR psscan >> ./vol-output/processes_dll/psscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR psdispscan >> ./vol-output/processes_dll/psdispscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR dlllist >> ./vol-output/processes_dll/dlllist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR dlldump >> ./vol-output/processes_dll/dlldump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR handles >> ./vol-output/processes_dll/handles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR getsids >> ./vol-output/processes_dll/getsids.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR cmdscan >> ./vol-output/processes_dll/cmdscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR consoles >> ./vol-output/processes_dll/consoles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR privs >> ./vol-output/processes_dll/privs.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR envars >> ./vol-output/processes_dll/envars.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR verinfo >> ./vol-output/processes_dll/verinfo.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR handles >> ./vol-output/processes_dll/handles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR enumfunc >> ./vol-output/processes_dll/enumfunc.txt 2>/dev/null
			echo "################################################ "
			echo "# 3 of 9 - Now outputting process memory files # "
			echo "################################################ "
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR memmap >> ./vol-output/process_memory/memmap.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR memdump >> ./vol-output/process_memory/memdump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR vadinfo >> ./vol-output/process_memory/vadinfo.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR vadwalk >> ./vol-output/process_memory/vadwalk.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR vadtree >> ./vol-output/process_memory/vadtree.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR iehistory >> ./vol-output/process_memory/iehistory.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR procmemdump >> ./vol-output/process_memory/procmemdump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR procexedump >> ./vol-output/process_memory/procexedump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR vaddump >> ./vol-output/process_memory/vaddump.txt 2>/dev/null
			echo "######################################################### "
			echo "# 4 of 9 - Now outputting kernel memory & objects files # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR modules >> ./vol-output/kernel_mem_modules/modules.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR modscan >> ./vol-output/kernel_mem_modules/modscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR moddump >> ./vol-output/kernel_mem_modules/moddump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR ssdt >> ./vol-output/kernel_mem_modules/ssdt.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR driverscan >> ./vol-output/kernel_mem_modules/driverscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR filescan >> ./vol-output/kernel_mem_modules/filescan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR mutantscan >> ./vol-output/kernel_mem_modules/mutantscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR symlinkscan >> ./vol-output/kernel_mem_modules/symlinkscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR thrdscan >> ./vol-output/kernel_mem_modules/thrdscan.txt 2>/dev/null
			echo "######################################################### "
			echo "# 5 of 9 - Now outputting networking files              # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR netscan >> ./vol-output/networking/netscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR connections >> ./vol-output/networking/connections.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR connscan >> ./vol-output/networking/connscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR sockets >> ./vol-output/networking/sockets.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR sockscan >> ./vol-output/networking/sockscan.txt 2>/dev/null
			echo "######################################################### "
			echo "# 6 of 9 - Now outputting registry files                # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR hivescan >> ./vol-output/registry/hivescan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR hivelist >> ./vol-output/registry/hivelist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR printkey >> ./vol-output/registry/printkey.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR lsadump >> ./vol-output/registry/lsadump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR hivedump >> ./vol-output/registry/hivedump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR hashdump >> ./vol-output/registry/hashdump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR userassist >> ./vol-output/registry/userassist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR shimcache >> ./vol-output/registry/shimcache.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR shellbags >> ./vol-output/registry/shellbags.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR getservicesids >> ./vol-output/registry/getservicesids.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR auditpol >> ./vol-output/registry/auditpol.txt 2>/dev/null
			echo "######################################################### "
			echo "# 7 of 9 - Now outputting malware/rootkits files        # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR malfind >> ./vol-output/malware_rootkits/malfind.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR yarascan>> ./vol-output/malware_rootkits/yarascan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR svcscan >> ./vol-output/malware_rootkits/svcscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR ldrmodules >> ./vol-output/malware_rootkits/ldrmodules.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR impscan >> ./vol-output/malware_rootkits/impscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR apihooks >> ./vol-output/malware_rootkits/apihooks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR idt >> ./vol-output/malware_rootkits/idt.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR gdt >> ./vol-output/malware_rootkits/gdt.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR threads >> ./vol-output/malware_rootkits/threads.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR callbacks >> ./vol-output/malware_rootkits/callbacks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR driverirp >> ./vol-output/malware_rootkits/driverirp.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR devicetree >> ./vol-output/malware_rootkits/devicetree.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR psxview >> ./vol-output/malware_rootkits/psxview.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR timers >> ./vol-output/malware_rootkits/timers.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR strings >> ./vol-output/malware_rootkits/strings.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR volshell >> ./vol-output/malware_rootkits/volshell.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR bioskbd >> ./vol-output/malware_rootkits/bioskbd.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR patcher >> ./vol-output/malware_rootkits/patcher.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR pagecheck >> ./vol-output/malware_rootkits/pagecheck.txt 2>/dev/null
			echo "######################################################### "
			echo "# 8 of 9 - Now outputting file system files             # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR mbrparser >> ./vol-output/file_system/master_boot_record.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR mftparser >> ./vol-output/file_system/master_file_table.txt 2>/dev/null
			echo "######################################################### "
			echo "# 9 of 9 - Now outputting misc. files                   # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR notepad --output=text --output-file=notepad.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR screenshot --output=text --output-file=screenshot.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR sessions --output=text --output-file=sessions.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR multiscan --output=text --output-file=multiscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR messagehooks --output=text --output-file=messagehooks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR dumpfiles --output=text --output-file=dumpfiles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR dumpcerts --output=text --output-file=dumpcerts.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR evtlogs --output=text --output-file=evtlogs.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR clipboard --output=text --output-file=clipboard.txt
			volatility -f $NEW_FILE --profile=$WIN7_FLAVOR eventhooks --output=text --output-file=eventhooks.txt
			volatility -f $NEW_FILE --profile=${WIN7_FLAVOR[Win7_OS-1]} gahti --output=text --output-file=gahti.txt
			echo "volatility -f $NEW_FILE --profile=${WIN7_FLAVOR[Win7_OS-1]} gahti --output=text --output-file=gahti.txt"
# Looks for empty files that were created from this script and deletes them.
			find ./vol-output -empty -type f -delete
			tar -cf $WIN7_FLAVOR.tar ./vol-output
			rm -rf ./vol-output
			type gzip > /dev/null
			if [ $? -eq 0 ] ; then gzip $WIN7_FLAVOR.tar
   			else compress $WIN7_FLAVOR.tar
			fi
			md5sum ./$WIN7_FLAVOR.tar.gz > Hash:$WIN7_FLAVOR-memory_cap
# Closing Messages
			echo				
			echo " ############################################################################################"
			echo " There is a new compressed file placed on your system."
			if [ -f ./$WIN7_FLAVOR.tar.gz ] ; then 
			echo " The tarball and hash is in the current working directory and is called $WIN7_FLAVOR.tar.gz"
			else 
			echo " The file is in the current working directory and is called $WIN7_FLAVOR.tar.gz"
fi
			fi
		done
    	fi
				if [ "$OPERATING_SYSTEM" -eq 3 ] ; then
	    	VISTA_FLAVOR=('VistaSP1x64' 'VistaSP1x86' 'VistaSP2x64' 'VistaSP2x86')
	    	VISTA_OS=
	        while [ -z "$VISTA_OS" ] ;
	        do
			echo
	        	echo
    	        	echo "  ***************************************"
   	       		echo "  Please select the CPU version of which"
    	       	 	echo "  the memory capture came from"
    	        	echo "  1 - VistaSP1x64"
    	        	echo "  2 - VistaSP1x86"
   	        	echo "  3 - VistaSP2x64"
    	        	echo "  4 - VistaSP2x86"
   	        	echo "    Select 1, 2, 3, or 4 :" \n
   	        	echo "  ***************************************"
   	        	printf "    Enter Selection> "; read VISTA_OS
	        	echo " You have selected - ${VISTA_FLAVOR[VISTA_OS-1]}"
	        	echo
                if [ "$VISTA_OS" -eq 1 ] ; then
			mkdir ./vol-output
			mkdir ./vol-output/image_id
			mkdir ./vol-output/processes_dll
			mkdir ./vol-output/process_memory
			mkdir ./vol-output/kernel_mem_modules
			mkdir ./vol-output/networking
			mkdir ./vol-output/registry
			mkdir ./vol-output/malware_rootkits
			mkdir ./vol-output/file_system
			mkdir ./vol-output/misc
			echo "###################################################### "
			echo "# 1 of 9 - Now outputting image identification files # "
			echo "###################################################### "
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR imageinfo >> ./vol-output/image_id/imageinfo.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR kdbgscan >> ./vol-output/image_id/kdbgscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR kpcrscan >> ./vol-output/image_id/kpcrscan.txt 2>/dev/null
			echo "#################################################### "
			echo "# 2 of 9 - Now outputting processess and dll files # "
			echo "#################################################### "
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR pslist >> ./vol-output/processes_dll/pslist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR pstree >> ./vol-output/processes_dll/pstree.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR psscan >> ./vol-output/processes_dll/psscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR psdispscan >> ./vol-output/processes_dll/psdispscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR dlllist >> ./vol-output/processes_dll/dlllist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR dlldump >> ./vol-output/processes_dll/dlldump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR handles >> ./vol-output/processes_dll/handles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR getsids >> ./vol-output/processes_dll/getsids.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR cmdscan >> ./vol-output/processes_dll/cmdscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR consoles >> ./vol-output/processes_dll/consoles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR privs >> ./vol-output/processes_dll/privs.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR envars >> ./vol-output/processes_dll/envars.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR verinfo >> ./vol-output/processes_dll/verinfo.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR handles >> ./vol-output/processes_dll/handles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR enumfunc >> ./vol-output/processes_dll/enumfunc.txt 2>/dev/null
			echo "################################################ "
			echo "# 3 of 9 - Now outputting process memory files # "
			echo "################################################ "
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR memmap >> ./vol-output/process_memory/memmap.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR memdump >> ./vol-output/process_memory/memdump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR vadinfo >> ./vol-output/process_memory/vadinfo.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR vadwalk >> ./vol-output/process_memory/vadwalk.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR vadtree >> ./vol-output/process_memory/vadtree.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR iehistory >> ./vol-output/process_memory/iehistory.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR procmemdump >> ./vol-output/process_memory/procmemdump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR procexedump >> ./vol-output/process_memory/procexedump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR vaddump >> ./vol-output/process_memory/vaddump.txt 2>/dev/null
			echo "######################################################### "
			echo "# 4 of 9 - Now outputting kernel memory & objects files # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR modules >> ./vol-output/kernel_mem_modules/modules.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR modscan >> ./vol-output/kernel_mem_modules/modscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR moddump >> ./vol-output/kernel_mem_modules/moddump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR ssdt >> ./vol-output/kernel_mem_modules/ssdt.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR driverscan >> ./vol-output/kernel_mem_modules/driverscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR filescan >> ./vol-output/kernel_mem_modules/filescan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR mutantscan >> ./vol-output/kernel_mem_modules/mutantscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR symlinkscan >> ./vol-output/kernel_mem_modules/symlinkscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR thrdscan >> ./vol-output/kernel_mem_modules/thrdscan.txt 2>/dev/null
			echo "######################################################### "
			echo "# 5 of 9 - Now outputting networking files              # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR netscan >> ./vol-output/networking/netscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR connections >> ./vol-output/networking/connections.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR connscan >> ./vol-output/networking/connscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR sockets >> ./vol-output/networking/sockets.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR sockscan >> ./vol-output/networking/sockscan.txt 2>/dev/null
			echo "######################################################### "
			echo "# 6 of 9 - Now outputting registry files                # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR hivescan >> ./vol-output/registry/hivescan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR hivelist >> ./vol-output/registry/hivelist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR printkey >> ./vol-output/registry/printkey.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR lsadump >> ./vol-output/registry/lsadump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR hivedump >> ./vol-output/registry/hivedump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR hashdump >> ./vol-output/registry/hashdump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR userassist >> ./vol-output/registry/userassist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR shimcache >> ./vol-output/registry/shimcache.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR shellbags >> ./vol-output/registry/shellbags.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR getservicesids >> ./vol-output/registry/getservicesids.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR auditpol >> ./vol-output/registry/auditpol.txt 2>/dev/null
			echo "######################################################### "
			echo "# 7 of 9 - Now outputting malware/rootkits files        # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR malfind >> ./vol-output/malware_rootkits/malfind.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR yarascan>> ./vol-output/malware_rootkits/yarascan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR svcscan >> ./vol-output/malware_rootkits/svcscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR ldrmodules >> ./vol-output/malware_rootkits/ldrmodules.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR impscan >> ./vol-output/malware_rootkits/impscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR apihooks >> ./vol-output/malware_rootkits/apihooks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR idt >> ./vol-output/malware_rootkits/idt.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR gdt >> ./vol-output/malware_rootkits/gdt.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR threads >> ./vol-output/malware_rootkits/threads.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR callbacks >> ./vol-output/malware_rootkits/callbacks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR driverirp >> ./vol-output/malware_rootkits/driverirp.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR devicetree >> ./vol-output/malware_rootkits/devicetree.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR psxview >> ./vol-output/malware_rootkits/psxview.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR timers >> ./vol-output/malware_rootkits/timers.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR strings >> ./vol-output/malware_rootkits/strings.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR volshell >> ./vol-output/malware_rootkits/volshell.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR bioskbd >> ./vol-output/malware_rootkits/bioskbd.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR patcher >> ./vol-output/malware_rootkits/patcher.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR pagecheck >> ./vol-output/malware_rootkits/pagecheck.txt 2>/dev/null
			echo "######################################################### "
			echo "# 8 of 9 - Now outputting file system files             # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR mbrparser >> ./vol-output/file_system/master_boot_record.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR mftparser >> ./vol-output/file_system/master_file_table.txt 2>/dev/null
			echo "######################################################### "
			echo "# 9 of 9 - Now outputting misc. files                   # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR notepad --output=text --output-file=notepad.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR screenshot --output=text --output-file=screenshot.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR sessions --output=text --output-file=sessions.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR multiscan --output=text --output-file=multiscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR messagehooks --output=text --output-file=messagehooks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR dumpfiles --output=text --output-file=dumpfiles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR dumpcerts --output=text --output-file=dumpcerts.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR evtlogs --output=text --output-file=evtlogs.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR clipboard --output=text --output-file=clipboard.txt
			volatility -f $NEW_FILE --profile=$VISTA_FLAVOR eventhooks --output=text --output-file=eventhooks.txt
			volatility -f $NEW_FILE --profile=${VISTA_FLAVOR[VISTA_OS-1]} gahti --output=text --output-file=gahti.txt
			echo "volatility -f $NEW_FILE --profile=${VISTA_FLAVOR[VISTA_OS-1]} gahti --output=text --output-file=gahti.txt"
# Looks for empty files that were created from this script and deletes them.
			find ./vol-output -empty -type f -delete
			tar -cf $VISTA_FLAVOR.tar ./vol-output
			rm -rf ./vol-output
			type gzip > /dev/null
			if [ $? -eq 0 ] ; then gzip $VISTA_FLAVOR.tar
   			else compress $VISTA_FLAVOR.tar
			fi
			md5sum ./$VISTA_FLAVOR.tar.gz > Hash:$VISTA_FLAVOR-memory_cap
# Closing Messages
			echo				
			echo " ############################################################################################"
			echo " There is a new compressed file placed on your system."
			if [ -f ./$VISTA_FLAVOR.tar.gz ] ; then 
			echo " The tarball and hash is in the current working directory and is called $VISTA_FLAVOR.tar.gz"
			else 
			echo " The file is in the current working directory and is called $VISTA_FLAVOR.tar.gz"
fi
			fi
		done
    	fi
		if [ "$OPERATING_SYSTEM" -eq 4 ] ; then
	    	WINXP_FLAVOR=('WinXPSP1x64' 'WinXPSP2x64' 'WinXPSP2x64' 'WinXPSP3x86')
	    	WINXP_OS=
	        while [ -z "$WINXP_OS" ] ;
	        do
			echo
	        	echo
    	        	echo "  ***************************************"
   	       		echo "  Please select the CPU version of which"
    	       	 	echo "  the memory capture came from"
    	        	echo "  1 - WinXPSP1x64"
    	        	echo "  2 - WinXPSP2x64"
   	        	echo "  3 - WinXPSP2x64"
    	        	echo "  4 - WinXPSP3x86"
   	        	echo "    Select 1, 2, 3, or 4 :" \n
   	        	echo "  ***************************************"
   	        	printf "    Enter Selection> "; read WINXP_OS
	        	echo " You have selected - ${WINXP_FLAVOR[WINXP_OS-1]}"
	        	echo
                if [ "$WINXP_OS" -eq 1 ] ; then
			mkdir ./vol-output
			mkdir ./vol-output/image_id
			mkdir ./vol-output/processes_dll
			mkdir ./vol-output/process_memory
			mkdir ./vol-output/kernel_mem_modules
			mkdir ./vol-output/networking
			mkdir ./vol-output/registry
			mkdir ./vol-output/malware_rootkits
			mkdir ./vol-output/file_system
			mkdir ./vol-output/misc
			echo "###################################################### "
			echo "# 1 of 9 - Now outputting image identification files # "
			echo "###################################################### "
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR imageinfo >> ./vol-output/image_id/imageinfo.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR kdbgscan >> ./vol-output/image_id/kdbgscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR kpcrscan >> ./vol-output/image_id/kpcrscan.txt 2>/dev/null
			echo "#################################################### "
			echo "# 2 of 9 - Now outputting processess and dll files # "
			echo "#################################################### "
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR pslist >> ./vol-output/processes_dll/pslist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR pstree >> ./vol-output/processes_dll/pstree.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR psscan >> ./vol-output/processes_dll/psscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR psdispscan >> ./vol-output/processes_dll/psdispscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR dlllist >> ./vol-output/processes_dll/dlllist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR dlldump >> ./vol-output/processes_dll/dlldump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR handles >> ./vol-output/processes_dll/handles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR getsids >> ./vol-output/processes_dll/getsids.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR cmdscan >> ./vol-output/processes_dll/cmdscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR consoles >> ./vol-output/processes_dll/consoles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR privs >> ./vol-output/processes_dll/privs.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR envars >> ./vol-output/processes_dll/envars.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR verinfo >> ./vol-output/processes_dll/verinfo.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR handles >> ./vol-output/processes_dll/handles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR enumfunc >> ./vol-output/processes_dll/enumfunc.txt 2>/dev/null
			echo "################################################ "
			echo "# 3 of 9 - Now outputting process memory files # "
			echo "################################################ "
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR memmap >> ./vol-output/process_memory/memmap.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR memdump >> ./vol-output/process_memory/memdump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR vadinfo >> ./vol-output/process_memory/vadinfo.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR vadwalk >> ./vol-output/process_memory/vadwalk.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR vadtree >> ./vol-output/process_memory/vadtree.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR iehistory >> ./vol-output/process_memory/iehistory.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR procmemdump >> ./vol-output/process_memory/procmemdump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR procexedump >> ./vol-output/process_memory/procexedump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR vaddump >> ./vol-output/process_memory/vaddump.txt 2>/dev/null
			echo "######################################################### "
			echo "# 4 of 9 - Now outputting kernel memory & objects files # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR modules >> ./vol-output/kernel_mem_modules/modules.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR modscan >> ./vol-output/kernel_mem_modules/modscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR moddump >> ./vol-output/kernel_mem_modules/moddump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR ssdt >> ./vol-output/kernel_mem_modules/ssdt.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR driverscan >> ./vol-output/kernel_mem_modules/driverscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR filescan >> ./vol-output/kernel_mem_modules/filescan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR mutantscan >> ./vol-output/kernel_mem_modules/mutantscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR symlinkscan >> ./vol-output/kernel_mem_modules/symlinkscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR thrdscan >> ./vol-output/kernel_mem_modules/thrdscan.txt 2>/dev/null
			echo "######################################################### "
			echo "# 5 of 9 - Now outputting networking files              # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR netscan >> ./vol-output/networking/netscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR connections >> ./vol-output/networking/connections.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR connscan >> ./vol-output/networking/connscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR sockets >> ./vol-output/networking/sockets.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR sockscan >> ./vol-output/networking/sockscan.txt 2>/dev/null
			echo "######################################################### "
			echo "# 6 of 9 - Now outputting registry files                # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR hivescan >> ./vol-output/registry/hivescan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR hivelist >> ./vol-output/registry/hivelist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR printkey >> ./vol-output/registry/printkey.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR lsadump >> ./vol-output/registry/lsadump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR hivedump >> ./vol-output/registry/hivedump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR hashdump >> ./vol-output/registry/hashdump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR userassist >> ./vol-output/registry/userassist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR shimcache >> ./vol-output/registry/shimcache.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR shellbags >> ./vol-output/registry/shellbags.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR getservicesids >> ./vol-output/registry/getservicesids.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR auditpol >> ./vol-output/registry/auditpol.txt 2>/dev/null
			echo "######################################################### "
			echo "# 7 of 9 - Now outputting malware/rootkits files        # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR malfind >> ./vol-output/malware_rootkits/malfind.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR yarascan>> ./vol-output/malware_rootkits/yarascan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR svcscan >> ./vol-output/malware_rootkits/svcscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR ldrmodules >> ./vol-output/malware_rootkits/ldrmodules.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR impscan >> ./vol-output/malware_rootkits/impscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR apihooks >> ./vol-output/malware_rootkits/apihooks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR idt >> ./vol-output/malware_rootkits/idt.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR gdt >> ./vol-output/malware_rootkits/gdt.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR threads >> ./vol-output/malware_rootkits/threads.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR callbacks >> ./vol-output/malware_rootkits/callbacks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR driverirp >> ./vol-output/malware_rootkits/driverirp.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR devicetree >> ./vol-output/malware_rootkits/devicetree.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR psxview >> ./vol-output/malware_rootkits/psxview.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR timers >> ./vol-output/malware_rootkits/timers.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR strings >> ./vol-output/malware_rootkits/strings.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR volshell >> ./vol-output/malware_rootkits/volshell.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR bioskbd >> ./vol-output/malware_rootkits/bioskbd.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR patcher >> ./vol-output/malware_rootkits/patcher.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR pagecheck >> ./vol-output/malware_rootkits/pagecheck.txt 2>/dev/null
			echo "######################################################### "
			echo "# 8 of 9 - Now outputting file system files             # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR mbrparser >> ./vol-output/file_system/master_boot_record.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR mftparser >> ./vol-output/file_system/master_file_table.txt 2>/dev/null
			echo "######################################################### "
			echo "# 9 of 9 - Now outputting misc. files                   # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR notepad --output=text --output-file=notepad.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR screenshot --output=text --output-file=screenshot.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR sessions --output=text --output-file=sessions.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR multiscan --output=text --output-file=multiscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR messagehooks --output=text --output-file=messagehooks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR dumpfiles --output=text --output-file=dumpfiles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR dumpcerts --output=text --output-file=dumpcerts.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR evtlogs --output=text --output-file=evtlogs.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR clipboard --output=text --output-file=clipboard.txt
			volatility -f $NEW_FILE --profile=$WINXP_FLAVOR eventhooks --output=text --output-file=eventhooks.txt
			volatility -f $NEW_FILE --profile=${WINXP_FLAVOR[WINXP_OS-1]} gahti --output=text --output-file=gahti.txt
			echo "volatility -f $NEW_FILE --profile=${WINXP_FLAVOR[WINXP_OS-1]} gahti --output=text --output-file=gahti.txt"
# Looks for empty files that were created from this script and deletes them.
			find ./vol-output -empty -type f -delete
			tar -cf $WINXP_FLAVOR.tar ./vol-output
			rm -rf ./vol-output
			type gzip > /dev/null
			if [ $? -eq 0 ] ; then gzip $WINXP_FLAVOR.tar
   			else compress $WINXP_FLAVOR.tar
			fi
			md5sum ./$WINXP_FLAVOR.tar.gz > Hash:$WINXP_FLAVOR-memory_cap
# Closing Messages
			echo				
			echo " ############################################################################################"
			echo " There is a new compressed file placed on your system."
			if [ -f ./$WINXP_FLAVOR.tar.gz ] ; then 
			echo " The tarball and hash is in the current working directory and is called $WINXP_FLAVOR.tar.gz"
			else 
			echo " The file is in the current working directory and is called $WINXP_FLAVOR.tar.gz"
fi
			fi
		done
    	fi
		if [ "$OPERATING_SYSTEM" -eq 5 ] ; then
	    	WIN2008_FLAVOR=('Win2008SP1x64' 'Win2008SP1x86' 'Win2008SP1x64' 'Win2008SP1x86')
	    	WIN2008_OS=
	        while [ -z "$WIN2008_OS" ] ;
	        do
			echo
	        	echo
    	        	echo "  ***************************************"
   	       		echo "  Please select the CPU version of which"
    	       	 	echo "  the memory capture came from"
    	        	echo "  1 - WIN2008SP1x64"
    	        	echo "  2 - WIN2008SP1x86"
   	        	echo "  3 - WIN2008SP2x64"
    	        	echo "  4 - WIN2008SP2x86"
   	        	echo "    Select 1, 2, 3, or 4 :" \n
   	        	echo "  ***************************************"
   	        	printf "    Enter Selection> "; read WIN2008_OS
	        	echo " You have selected - ${WIN2008_FLAVOR[WIN2008_OS-1]}"
	        	echo
                if [ "$WIN2008_OS" -eq 1 ] ; then
			mkdir ./vol-output
			mkdir ./vol-output/image_id
			mkdir ./vol-output/processes_dll
			mkdir ./vol-output/process_memory
			mkdir ./vol-output/kernel_mem_modules
			mkdir ./vol-output/networking
			mkdir ./vol-output/registry
			mkdir ./vol-output/malware_rootkits
			mkdir ./vol-output/file_system
			mkdir ./vol-output/misc
			echo "###################################################### "
			echo "# 1 of 9 - Now outputting image identification files # "
			echo "###################################################### "
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR imageinfo >> ./vol-output/image_id/imageinfo.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR kdbgscan >> ./vol-output/image_id/kdbgscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR kpcrscan >> ./vol-output/image_id/kpcrscan.txt 2>/dev/null
			echo "#################################################### "
			echo "# 2 of 9 - Now outputting processess and dll files # "
			echo "#################################################### "
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR pslist >> ./vol-output/processes_dll/pslist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR pstree >> ./vol-output/processes_dll/pstree.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR psscan >> ./vol-output/processes_dll/psscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR psdispscan >> ./vol-output/processes_dll/psdispscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR dlllist >> ./vol-output/processes_dll/dlllist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR dlldump >> ./vol-output/processes_dll/dlldump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR handles >> ./vol-output/processes_dll/handles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR getsids >> ./vol-output/processes_dll/getsids.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR cmdscan >> ./vol-output/processes_dll/cmdscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR consoles >> ./vol-output/processes_dll/consoles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR privs >> ./vol-output/processes_dll/privs.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR envars >> ./vol-output/processes_dll/envars.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR verinfo >> ./vol-output/processes_dll/verinfo.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR handles >> ./vol-output/processes_dll/handles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR enumfunc >> ./vol-output/processes_dll/enumfunc.txt 2>/dev/null
			echo "################################################ "
			echo "# 3 of 9 - Now outputting process memory files # "
			echo "################################################ "
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR memmap >> ./vol-output/process_memory/memmap.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR memdump >> ./vol-output/process_memory/memdump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR vadinfo >> ./vol-output/process_memory/vadinfo.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR vadwalk >> ./vol-output/process_memory/vadwalk.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR vadtree >> ./vol-output/process_memory/vadtree.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR iehistory >> ./vol-output/process_memory/iehistory.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR procmemdump >> ./vol-output/process_memory/procmemdump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR procexedump >> ./vol-output/process_memory/procexedump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR vaddump >> ./vol-output/process_memory/vaddump.txt 2>/dev/null
			echo "######################################################### "
			echo "# 4 of 9 - Now outputting kernel memory & objects files # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR modules >> ./vol-output/kernel_mem_modules/modules.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR modscan >> ./vol-output/kernel_mem_modules/modscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR moddump >> ./vol-output/kernel_mem_modules/moddump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR ssdt >> ./vol-output/kernel_mem_modules/ssdt.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR driverscan >> ./vol-output/kernel_mem_modules/driverscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR filescan >> ./vol-output/kernel_mem_modules/filescan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR mutantscan >> ./vol-output/kernel_mem_modules/mutantscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR symlinkscan >> ./vol-output/kernel_mem_modules/symlinkscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR thrdscan >> ./vol-output/kernel_mem_modules/thrdscan.txt 2>/dev/null
			echo "######################################################### "
			echo "# 5 of 9 - Now outputting networking files              # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR netscan >> ./vol-output/networking/netscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR connections >> ./vol-output/networking/connections.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR connscan >> ./vol-output/networking/connscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR sockets >> ./vol-output/networking/sockets.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR sockscan >> ./vol-output/networking/sockscan.txt 2>/dev/null
			echo "######################################################### "
			echo "# 6 of 9 - Now outputting registry files                # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR hivescan >> ./vol-output/registry/hivescan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR hivelist >> ./vol-output/registry/hivelist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR printkey >> ./vol-output/registry/printkey.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR lsadump >> ./vol-output/registry/lsadump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR hivedump >> ./vol-output/registry/hivedump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR hashdump >> ./vol-output/registry/hashdump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR userassist >> ./vol-output/registry/userassist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR shimcache >> ./vol-output/registry/shimcache.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR shellbags >> ./vol-output/registry/shellbags.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR getservicesids >> ./vol-output/registry/getservicesids.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR auditpol >> ./vol-output/registry/auditpol.txt 2>/dev/null
			echo "######################################################### "
			echo "# 7 of 9 - Now outputting malware/rootkits files        # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR malfind >> ./vol-output/malware_rootkits/malfind.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR yarascan>> ./vol-output/malware_rootkits/yarascan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR svcscan >> ./vol-output/malware_rootkits/svcscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR ldrmodules >> ./vol-output/malware_rootkits/ldrmodules.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR impscan >> ./vol-output/malware_rootkits/impscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR apihooks >> ./vol-output/malware_rootkits/apihooks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR idt >> ./vol-output/malware_rootkits/idt.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR gdt >> ./vol-output/malware_rootkits/gdt.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR threads >> ./vol-output/malware_rootkits/threads.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR callbacks >> ./vol-output/malware_rootkits/callbacks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR driverirp >> ./vol-output/malware_rootkits/driverirp.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR devicetree >> ./vol-output/malware_rootkits/devicetree.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR psxview >> ./vol-output/malware_rootkits/psxview.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR timers >> ./vol-output/malware_rootkits/timers.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR strings >> ./vol-output/malware_rootkits/strings.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR volshell >> ./vol-output/malware_rootkits/volshell.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR bioskbd >> ./vol-output/malware_rootkits/bioskbd.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR patcher >> ./vol-output/malware_rootkits/patcher.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR pagecheck >> ./vol-output/malware_rootkits/pagecheck.txt 2>/dev/null
			echo "######################################################### "
			echo "# 8 of 9 - Now outputting file system files             # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR mbrparser >> ./vol-output/file_system/master_boot_record.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR mftparser >> ./vol-output/file_system/master_file_table.txt 2>/dev/null
			echo "######################################################### "
			echo "# 9 of 9 - Now outputting misc. files                   # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR notepad --output=text --output-file=notepad.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR screenshot --output=text --output-file=screenshot.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR sessions --output=text --output-file=sessions.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR multiscan --output=text --output-file=multiscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR messagehooks --output=text --output-file=messagehooks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR dumpfiles --output=text --output-file=dumpfiles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR dumpcerts --output=text --output-file=dumpcerts.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR evtlogs --output=text --output-file=evtlogs.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR clipboard --output=text --output-file=clipboard.txt
			volatility -f $NEW_FILE --profile=$WIN2008_FLAVOR eventhooks --output=text --output-file=eventhooks.txt
			volatility -f $NEW_FILE --profile=${WIN2008_FLAVOR[WIN2008_OS-1]} gahti --output=text --output-file=gahti.txt
			echo "volatility -f $NEW_FILE --profile=${WIN2008_FLAVOR[WIN2008_OS-1]} gahti --output=text --output-file=gahti.txt"
# Looks for empty files that were created from this script and deletes them.
			find ./vol-output -empty -type f -delete
			tar -cf $WIN2008_FLAVOR.tar ./vol-output
			rm -rf ./vol-output
			type gzip > /dev/null
			if [ $? -eq 0 ] ; then gzip $WIN2008_FLAVOR.tar
   			else compress $WIN2008_FLAVOR.tar
			fi
			md5sum ./$WIN2008_FLAVOR.tar.gz > Hash:$WIN2008_FLAVOR-memory_cap
# Closing Messages
			echo				
			echo " ############################################################################################"
			echo " There is a new compressed file placed on your system."
			if [ -f ./$WIN2008_FLAVOR.tar.gz ] ; then 
			echo " The tarball and hash is in the current working directory and is called $WIN2008_FLAVOR.tar.gz"
			else 
			echo " The file is in the current working directory and is called $WIN2008_FLAVOR.tar.gz"
fi
			fi
		done
    	fi
		if [ "$OPERATING_SYSTEM" -eq 6 ] ; then
	    	WIN2012_FLAVOR=('Win2012R2x64' 'Win2012x64')
	    	WIN2012_OS=
	        while [ -z "$WIN2012_OS" ] ;
	        do
			echo
	        	echo
    	        	echo "  ***************************************"
   	       		echo "  Please select the CPU version of which"
    	       	 	echo "  the memory capture came from"
    	        	echo "  1 - Win2012R2x64"
    	        	echo "  2 - Win2012x64""
   	        	echo "    Select 1 or 2 :" \n
   	        	echo "  ***************************************"
   	        	printf "    Enter Selection> "; read WIN2012_OS
	        	echo " You have selected - ${WIN2012_FLAVOR[WIN2012_OS-1]}"
	        	echo
                if [ "$WIN2012_OS" -eq 1 ] ; then
			mkdir ./vol-output
			mkdir ./vol-output/image_id
			mkdir ./vol-output/processes_dll
			mkdir ./vol-output/process_memory
			mkdir ./vol-output/kernel_mem_modules
			mkdir ./vol-output/networking
			mkdir ./vol-output/registry
			mkdir ./vol-output/malware_rootkits
			mkdir ./vol-output/file_system
			mkdir ./vol-output/misc
			echo "###################################################### "
			echo "# 1 of 9 - Now outputting image identification files # "
			echo "###################################################### "
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR imageinfo >> ./vol-output/image_id/imageinfo.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR kdbgscan >> ./vol-output/image_id/kdbgscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR kpcrscan >> ./vol-output/image_id/kpcrscan.txt 2>/dev/null
			echo "#################################################### "
			echo "# 2 of 9 - Now outputting processess and dll files # "
			echo "#################################################### "
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR pslist >> ./vol-output/processes_dll/pslist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR pstree >> ./vol-output/processes_dll/pstree.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR psscan >> ./vol-output/processes_dll/psscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR psdispscan >> ./vol-output/processes_dll/psdispscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR dlllist >> ./vol-output/processes_dll/dlllist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR dlldump >> ./vol-output/processes_dll/dlldump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR handles >> ./vol-output/processes_dll/handles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR getsids >> ./vol-output/processes_dll/getsids.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR cmdscan >> ./vol-output/processes_dll/cmdscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR consoles >> ./vol-output/processes_dll/consoles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR privs >> ./vol-output/processes_dll/privs.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR envars >> ./vol-output/processes_dll/envars.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR verinfo >> ./vol-output/processes_dll/verinfo.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR handles >> ./vol-output/processes_dll/handles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR enumfunc >> ./vol-output/processes_dll/enumfunc.txt 2>/dev/null
			echo "################################################ "
			echo "# 3 of 9 - Now outputting process memory files # "
			echo "################################################ "
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR memmap >> ./vol-output/process_memory/memmap.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR memdump >> ./vol-output/process_memory/memdump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR vadinfo >> ./vol-output/process_memory/vadinfo.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR vadwalk >> ./vol-output/process_memory/vadwalk.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR vadtree >> ./vol-output/process_memory/vadtree.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR iehistory >> ./vol-output/process_memory/iehistory.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR procmemdump >> ./vol-output/process_memory/procmemdump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR procexedump >> ./vol-output/process_memory/procexedump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR vaddump >> ./vol-output/process_memory/vaddump.txt 2>/dev/null
			echo "######################################################### "
			echo "# 4 of 9 - Now outputting kernel memory & objects files # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR modules >> ./vol-output/kernel_mem_modules/modules.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR modscan >> ./vol-output/kernel_mem_modules/modscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR moddump >> ./vol-output/kernel_mem_modules/moddump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR ssdt >> ./vol-output/kernel_mem_modules/ssdt.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR driverscan >> ./vol-output/kernel_mem_modules/driverscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR filescan >> ./vol-output/kernel_mem_modules/filescan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR mutantscan >> ./vol-output/kernel_mem_modules/mutantscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR symlinkscan >> ./vol-output/kernel_mem_modules/symlinkscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR thrdscan >> ./vol-output/kernel_mem_modules/thrdscan.txt 2>/dev/null
			echo "######################################################### "
			echo "# 5 of 9 - Now outputting networking files              # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR netscan >> ./vol-output/networking/netscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR connections >> ./vol-output/networking/connections.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR connscan >> ./vol-output/networking/connscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR sockets >> ./vol-output/networking/sockets.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR sockscan >> ./vol-output/networking/sockscan.txt 2>/dev/null
			echo "######################################################### "
			echo "# 6 of 9 - Now outputting registry files                # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR hivescan >> ./vol-output/registry/hivescan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR hivelist >> ./vol-output/registry/hivelist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR printkey >> ./vol-output/registry/printkey.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR lsadump >> ./vol-output/registry/lsadump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR hivedump >> ./vol-output/registry/hivedump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR hashdump >> ./vol-output/registry/hashdump.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR userassist >> ./vol-output/registry/userassist.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR shimcache >> ./vol-output/registry/shimcache.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR shellbags >> ./vol-output/registry/shellbags.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR getservicesids >> ./vol-output/registry/getservicesids.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR auditpol >> ./vol-output/registry/auditpol.txt 2>/dev/null
			echo "######################################################### "
			echo "# 7 of 9 - Now outputting malware/rootkits files        # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR malfind >> ./vol-output/malware_rootkits/malfind.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR yarascan>> ./vol-output/malware_rootkits/yarascan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR svcscan >> ./vol-output/malware_rootkits/svcscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR ldrmodules >> ./vol-output/malware_rootkits/ldrmodules.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR impscan >> ./vol-output/malware_rootkits/impscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR apihooks >> ./vol-output/malware_rootkits/apihooks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR idt >> ./vol-output/malware_rootkits/idt.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR gdt >> ./vol-output/malware_rootkits/gdt.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR threads >> ./vol-output/malware_rootkits/threads.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR callbacks >> ./vol-output/malware_rootkits/callbacks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR driverirp >> ./vol-output/malware_rootkits/driverirp.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR devicetree >> ./vol-output/malware_rootkits/devicetree.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR psxview >> ./vol-output/malware_rootkits/psxview.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR timers >> ./vol-output/malware_rootkits/timers.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR strings >> ./vol-output/malware_rootkits/strings.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR volshell >> ./vol-output/malware_rootkits/volshell.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR bioskbd >> ./vol-output/malware_rootkits/bioskbd.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR patcher >> ./vol-output/malware_rootkits/patcher.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR pagecheck >> ./vol-output/malware_rootkits/pagecheck.txt 2>/dev/null
			echo "######################################################### "
			echo "# 8 of 9 - Now outputting file system files             # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR mbrparser >> ./vol-output/file_system/master_boot_record.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR mftparser >> ./vol-output/file_system/master_file_table.txt 2>/dev/null
			echo "######################################################### "
			echo "# 9 of 9 - Now outputting misc. files                   # "
			echo "######################################################### "
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR notepad --output=text --output-file=notepad.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR screenshot --output=text --output-file=screenshot.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR sessions --output=text --output-file=sessions.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR multiscan --output=text --output-file=multiscan.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR messagehooks --output=text --output-file=messagehooks.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR dumpfiles --output=text --output-file=dumpfiles.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR dumpcerts --output=text --output-file=dumpcerts.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR evtlogs --output=text --output-file=evtlogs.txt 2>/dev/null
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR clipboard --output=text --output-file=clipboard.txt
			volatility -f $NEW_FILE --profile=$WIN2012_FLAVOR eventhooks --output=text --output-file=eventhooks.txt
			volatility -f $NEW_FILE --profile=${WIN2012_FLAVOR[WIN2012_OS-1]} gahti --output=text --output-file=gahti.txt
			echo "volatility -f $NEW_FILE --profile=${WIN2012_FLAVOR[WIN2012_OS-1]} gahti --output=text --output-file=gahti.txt"
# Looks for empty files that were created from this script and deletes them.
			find ./vol-output -empty -type f -delete
			tar -cf $WIN2012_FLAVOR.tar ./vol-output
			rm -rf ./vol-output
			type gzip > /dev/null
			if [ $? -eq 0 ] ; then gzip $WIN2012_FLAVOR.tar
   			else compress $WIN2012_FLAVOR.tar
			fi
			md5sum ./$WIN2012_FLAVOR.tar.gz > Hash:$WIN2012_FLAVOR-memory_cap
# Closing Messages
			echo				
			echo " ############################################################################################"
			echo " There is a new compressed file placed on your system."
			if [ -f ./$WIN2012_FLAVOR.tar.gz ] ; then 
			echo " The tarball and hash is in the current working directory and is called $WIN2012_FLAVOR.tar.gz"
			else 
			echo " The file is in the current working directory and is called $WIN2012_FLAVOR.tar.gz"
fi
		
		done
    	fi
    	    	   	    	
    	
    	
done