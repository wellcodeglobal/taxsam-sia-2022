export default class Ajax {
  static post(url, options){
    let xhr = new XMLHttpRequest();
    xhr.open('POST', url);

    if(options.headers){
      for(let i=0; i<options.headers.length; i++){
        let current = options.headers[i];
        xhr.setRequestHeader(current.key, current.value);
      }
    }

    xhr.onload = () => {
      if (xhr.status === 200) {
        if (typeof options.onSuccess === 'function') {
          options.onSuccess(xhr.responseText);
        }
      } else {
        if(typeof options.onFail === 'function'){
          options.onFail(xhr.responseText);
        }
      }

      if (typeof options.onDone === 'function') {
        options.onDone(xhr.responseText);
      }

      return;
    };

    if(typeof options.onProgress === 'function'){
      xhr.addEventListener('progress', options.onProgress);
    }

    xhr.send(options.data);
  }

  static get(url, options) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', url);

    if(options.headers){
      for(let i=0; i<options.headers.length; i++){
        let current = options.headers[i];
        xhr.setRequestHeader(current.key, current.value);
      }
    }

    xhr.onload = function() {
      if (xhr.status === 200) {
        if (typeof options.onSuccess === 'function') {
          options.onSuccess(xhr.responseText);
        }
      } else {
        if (typeof options.onFail === 'function') {
          options.onFail(xhr.responseText);
        }
      }

      if (typeof options.onDone === 'function') {
        options.onDone(xhr.responseText);
      }
    };

    xhr.send();
    return xhr;
  }

  static delete(url, options){
    window.Util.showLoader();
    let xhr = new XMLHttpRequest();
    xhr.open('DELETE', url);

    window.Ajax.applyOptions(xhr, options);

    xhr.onload = () => {
      if(xhr.status === 200){
        if(typeof options.onSuccess === 'function'){
          options.onSuccess(xhr.responseText);
        }
      }

      if(typeof options.onDone === 'function'){
        options.onDone(xhr.responseText);
      }

      return;
    };

    xhr.send(options.data);
  }

  static put(url, options){
    let xhr = new XMLHttpRequest();
    xhr.open('PUT', url);

    window.Ajax.applyOptions(xhr, options);

    xhr.onload = () => {
      if(xhr.status === 200){
        if(typeof options.onSuccess === 'function'){
          options.onSuccess(xhr.responseText);
        }
      } else {
        if(typeof options.onFail === 'function'){
          options.onFail(xhr.responseText);
        }
      }

      if(typeof options.onDone === 'function'){
        options.onDone(xhr.responseText);
      }

      return;
    };

    xhr.send(options.data);
  }

  static applyOptions(xhr, options){
    if(options.headers){
      for(let i=0; i<options.headers.length; i++){
        let current = options.headers[i];
        xhr.setRequestHeader(current.key, current.value);
      }
    }
  }
}
