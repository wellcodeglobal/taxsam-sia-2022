export default class Util {
  static isDesktop(desktopWidth=800){
    let index = navigator.appVersion.indexOf("Mobile");
    if (index < 0) {
      return (document.body.offsetWidth + 15) > desktopWidth;
    }
    return document.body.offsetWidth > desktopWidth;
  }

  static extend(obj, src) {
    for (let key in src) {
      if (src.hasOwnProperty(key)) obj[key] = src[key];
    }
    return obj;
  }

  static withLeadingZero(number, size) {
    var result = number+"";
    while (result.length < size) result = "0" + result;
    return result;
  }

  static removeElement(element){
    let parentElement = element.parentElement;
    parentElement.removeChild(element);
  }

  static emptyClass(element){
    var classList = element.classList;
    while (classList.length > 0) {
      classList.remove(classList.item(0));
    }
  }

  static secureMathRandom() {
    return window.crypto.getRandomValues(new Uint32Array(1))[0] / 1e+10
  }

  static secureMathRandomInt() {
    let random = window.Util.secureMathRandom();
    return Math.floor(random * 10000);
  }

  static secureRandomAlphabet(length) {
    let result = '';
    let characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    let charactersLength = characters.length;
    for ( let i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }

    return result;
  }

  static showLoader(options=null){
    let loader = document.getElementById('js-loader-v2');

    if(!loader){
      return;
    }

    if(!options){
      window.scrollTo(0,0);
      document.body.classList.add('no-overflow');
      loader.classList.remove('hidden');
      return;
    }

    if(!options && !options.noScroll){
      window.scrollTo(0,0);
    }

    document.body.classList.add('no-overflow');
    loader.classList.remove('hidden');
  }

  static hideLoader(){
    let loader = document.getElementById('js-loader-v2');

    if(!loader){
      return;
    }

    document.body.classList.remove('no-overflow');
    loader.classList.add('hidden');
  }

  static getCsrfToken(){
    let csrfTokenElement = document.head.querySelector('meta[name="csrf-token"]');
    return csrfTokenElement.content;
  }

  static isLandingPage(){
    return window.location.pathname === '/';
  }

  static uuidv4() {
    return ([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g, c =>
      (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
    )
  }

  static addThousandSeparator(value){
    if(value === ''){
      return;
    }

    let valueCommaToken = value.toString().split(',');

    let valueBeforeComma = window.Util.processValueBeforeComma(valueCommaToken[0]);
    let valueAfterComma = window.Util.processValueAfterComma(valueCommaToken[1], value);

    return `${valueBeforeComma}${valueAfterComma}`;
  }

  static processValueBeforeComma(value){
    let valuesBeforeComma = window.Util.removeSeparatorNumber(value);

    let tempLengthRunning = valuesBeforeComma.length;
    for(let i=0; tempLengthRunning > 3; i++){
      tempLengthRunning -= 3;
      valuesBeforeComma.splice(tempLengthRunning, 0, '.');
    }

    return valuesBeforeComma.join('');
  }

  static processValueAfterComma(value, currentValue){
    let result = value;

    if(result){
      return `,${result}`;
    }

    if(currentValue[currentValue.length-1] === ','){
      return ',';
    }

    return '';
  }

  static removeSeparatorNumber(number){
    let result = [];

    let token = number.split('');
    for(let i=0; i<token.length; i++){
      if(token[i] === '.') {
        continue;
      }

      result.push(token[i]);
    }

    return result;
  }

  static getMerchantCodeFromPath(){
    return window.location.pathname.split('/')[1];
  }

  static isObjectEmpty(object) {
    for(let key in object) {
      if(object.hasOwnProperty(key)){
        return false;
      }
    }

    return true;
  }

  static enableScrollOnBody(){
    document.body.classList.remove('no-overflow');
  }

  static disableScrollOnBody(){
    document.body.classList.add('no-overflow');
  }

  static capitalize(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
  }
}
