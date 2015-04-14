import 'domain_model.dart';

use_case_1 (Receptionist receptionist) {

   Message message;

   /* Preconditions */
   Matcher.has (receptionist.selected_contact());

   /* Use case body */
   receptionist.types_in(message);
   receptionist.sends(message);
   receptionist.marks_state(idle);

   /* Postconditions */
   Matcher.equals (is_stored (message));
   Matcher.equals (is_idle (receptionist));
}