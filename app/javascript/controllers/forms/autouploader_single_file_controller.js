import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['file'];

  connect(){
    this.bindChangeFile();
  }

  bindChangeFile(){
    this.fileTarget.addEventListener('change', this.handleChangeFile.bind(this));
  }

  handleChangeFile(){
    KTApp.blockPage();
    this.element.submit();
  }
}
