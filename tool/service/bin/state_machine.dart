//http://staff.washington.edu/jon/z/fsm.html
//
//STATE ::= patients | fields | setup | ready | beam_on
//EVENT ::= select_patient | select_field | enter | start | stop | ok | intlk
//FSM == (STATE \cross EVENT) \pfun STATE
//
//\begin{axdef}
//  no_change, transitions, control: FSM
//\where
//  control = no_change \oplus transitions
//
//  no_change = {  s: STATE; e: EVENT @ (s, e) \mapsto s  }
//
//  transitions = {  (patients, enter) \mapsto fields,
//
//  (fields, select_patient) \mapsto patients, (fields, enter) \mapsto setup,
//
//  (setup, select_patient) \mapsto patients, (setup, select_field) \mapsto fields, (setup, ok) \mapsto ready,
//
//  (ready, select_patient) \mapsto patients, (ready, select_field) \mapsto fields, (ready, start) \mapsto beam_on, (ready, intlk) \mapsto setup,
//
//  (beam_on, stop) \mapsto ready, (beam_on, intlk) \mapsto setup  }