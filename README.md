# edgerouter_poe_cron
scripts and instructions for controlling the poe on an edgerouter via cron

## Customize the scripts
In order to utilize these scripts you must alter them to the specifics of your network devices. The line of interest is the `set` line of both the poe_on and poe_off scripts. 

    $WR set interfaces ethernet <<eth4>> poe output <<off>>
    
The available values you can use in place of `<<eth4>>` will depend on your router. On the edgerouter POE all 5 jacks are capable of supplying power so the available options are (`eth0`, `eth1`, `eth2`, `eth3`, `eth4`)  

The available values you can use in place of `<<off>>` are (`24v`, `48v`, `off`)  
You should exercise caution when setting the voltage because setting the wrong value could result in the hardware that is connected becoming damaged.
The appropriate setting for your specific connected device should be found in the device manufacturers documentation

I use two different Unifi APs
1. AC Lite which requires `24v` 
1. AC NanoHD which requires `48v`

## Where to place the scripts
SSH onto your edgerouter and place the scripts at `/config/user-data/`
This location will be preserved during firmware upgrades so that you will not need to perform this task again in the future.

## Don't go editing the crontab
At this point you are ready to enable the cron jobs, however, for the sake of these changes surviving a firmware upgrade you must add them in a proprietary fashion.
1. SSH onto your edgerouter
1. enter configure mode by typing `configure`
1. two commands will be required for each cron entry
    set system task-scheduler task POWERDOWN crontab-spec "0 6 * * 6"
    set system task-scheduler task POWERDOWN executable path /config/user-data/poe_off.sh
1. repeat that for the POWERON task and any other schedules you would like to program
1. once all task-scheduler entries have been created you must commit and save them
    commit
    save
    exit
    
## Helpful Hint
While initially setting this up or debugging your schedules it is helpful to do so while physically hardwired to your router. That way if you accidentally turn an access point off you will still be connected. Just be sure not to turn on POE to the jack you are connected to! 
