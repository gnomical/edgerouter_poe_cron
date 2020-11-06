#!/bin/bash
WR="/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper"

$WR begin
$WR set interfaces ethernet eth4 poe output 24v
$WR commit
$WR end
