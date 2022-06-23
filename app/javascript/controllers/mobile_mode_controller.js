import { Controller } from 'stimulus';

export default class extends Controller {
  connect(){
  }

  initialize(){
    var _asideEl;
    var _asideOffcanvas;
    _asideEl = document.querySelector('#kt_profile_aside');

    _asideOffcanvas = new KTOffcanvas(_asideEl, {
      overlay: true,
      baseClass: 'offcanvas-mobile',
      //closeBy: 'kt_profile_aside',
      toggleBy: 'kt_subheader_mobile_toggle'
    });
  }
}