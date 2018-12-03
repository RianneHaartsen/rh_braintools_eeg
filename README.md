# rh_braintools_eeg
Preproc scripts for EEG data in the braintools battery
(3 Dec 2018)

'braintools_eegQC_RH' preprocesses the EEG data collected as part of the UK and India braintools battery
This script calls onto the other functions in the respository, functions from LM (ECKAnalyse, eegtools, lm_tools, and others), 
functions from eeglab, and functions from FieldTrip version 'fieldtrip-20180925'.
Output includes 
a) quality control report for whole session, 
b) clean ERPs for FastERP task (faces up/inv, obj up/inv, checkers), and 
c) clear ERPs for AudERP task (first standard, deviant1, and deviant2).
