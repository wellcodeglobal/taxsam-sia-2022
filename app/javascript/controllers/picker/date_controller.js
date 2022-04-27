import { Controller } from 'stimulus';

export default class extends Controller {
  connect(){
    $(this.element).datepicker({
      todayHighlight: true,
      autoclose: true,
      format: 'dd/mm/yyyy'
    });
  }
}
