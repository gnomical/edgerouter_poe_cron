#!/bin/bash
WR="/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper"

$WR begin
$WR set interfaces ethernet eth4 poe output off
$WR commit
$WR end
