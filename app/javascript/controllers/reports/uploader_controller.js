import { Controller } from 'stimulus';

export default class extends Controller {
  connect(){
    this.element.dropzone.on("complete", this.handleChangeFile.bind(this));
  }

  handleChangeFile(){    
    this.performRequest();
  }

  performRequest(e){  
    let url = this.element.dataset.url;
    let idFile = document.querySelector("input[name='import[file][]']").value
    url = url.replace('default', idFile)
    window.Ajax.get(url, this.ajaxOptions());
  }

  ajaxOptions(){
    return {
      headers: [
        {
          key: 'Content-Type',
          value: 'application/html'
        }
      ],
      onSuccess: this.handleSuccess.bind(this),
      onFail: this.handleFail.bind(this),
      onDone: this.handleDone.bind(this)
    }
  }

  handleSuccess(response){
    this.replacer = document.querySelector("#preview-table-file")
    let tmp = document.createElement("div");
    tmp.innerHTML = response
    this.replacer.replaceChild(tmp, this.replacer.firstElementChild);
  }  

  handleFail(e){
    console.log(e)
  }  

  handleDone(e){
    console.log(e)
  }  
}
