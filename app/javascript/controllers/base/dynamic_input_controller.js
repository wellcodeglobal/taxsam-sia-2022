import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = [ 'element', 'input', 'markdownIndex' ];

  initialize(){
    this.insertionAdjacentPosition = this.data.get('insertionAdjacentPosition');

    if(this.hasElementTarget){
      this.clonedElement = this.elementTarget.cloneNode(true);
    }
  }

  add(){
    const lastInputElement = this.elementTargets[this.elementTargets.length-1]
    const clonedElement = this.clonedElement.cloneNode(true);
    this.clearAllInputFor(clonedElement);

    this.generateIndexInInputNameForRequestingElements(clonedElement);
    lastInputElement.insertAdjacentElement(this.insertionAdjacentPosition, clonedElement);
    this.generateIdForRespectedInputElements();
    this.generateIndexInMarkdownTextForRequestingElements();
  }

  remove(e){
    if(this.elementTargets.length <= 1){
      return;
    }

    let inputElement = e.srcElement;
    while(inputElement.getAttribute('data-base--dynamic-input-target') !== 'element'){
      inputElement = inputElement.parentElement;
    }
    window.Util.removeElement(inputElement);
    this.dispatchFormRemoval(inputElement);
    this.generateIndexInInputNameForRequestingElements();
    this.generateIndexInMarkdownTextForRequestingElements();
  }

  dispatchFormRemoval(inputElement){
    let priceElement = inputElement.querySelector('input[type="text"][data-controller="order-input-price"]');
    if (!priceElement) {
      return
    }

    let generatedId = priceElement.dataset.generatedId;

    let eventName = 'order-total-price_component-remove';
    let event = new CustomEvent(eventName, { detail: {
      id: generatedId
    }});

    window.dispatchEvent(event);
  }

  clearAllInputFor(element){
    element.classList.remove('hidden');

    const excluded_subjects = [
      '([name="letter_delivery_finished_good[letter_delivery_finished_goods_lines_attributes][][group]"])',
      '([type="radio"])',
      '([data-base--dynamic-input-exclude-clearing="1"])',
    ]
    let excluded_selector = `:not${excluded_subjects.join(':not')}`;

    Array.prototype.slice.call(
      element.querySelectorAll(`select,input${excluded_selector},textarea`)
    ).forEach((inputElement) => {
      inputElement.value = '';
      inputElement.removeAttribute('disabled');
    });

    let bodyTaxes = element.querySelector(".js-hide-taxes")
    let checkedTransaction = $("input[name='general_transaction[type_transaction]']:checked")
    if(bodyTaxes && checkedTransaction){
      if(checkedTransaction.val() == "expense"){
        bodyTaxes.classList.add("d-none")
      }
    }
  }

  generateIdForRespectedInputElements(){
    const respectedElements = Array.prototype.slice.call(
      this.element.querySelectorAll('input[data-base--dynamic-input-respect-id="1"],select[data-base--dynamic-input-respect-id="1"]')
    );

    respectedElements.forEach((element) => {
      element.id = `Item-${window.Util.uuidv4()}`;
    });
  }

  generateIndexInInputNameForRequestingElements(clonedElement=null){
    if(this.data.get('requestingIndex') !== '1'){
      return;
    }
    if(clonedElement == null){
      return;
    }

    let i;
    for(i=0; i<this.elementTargets.length; i++){
      const element = this.elementTargets[i];

      const inputElements = Array.prototype.slice.call(
        element.querySelectorAll('input,select,radio')
      );
      inputElements.forEach((inputElement) => {

        if (inputElement.name.includes("metrices")){
          inputElement.name = inputElement
            .name
            .replace(/\[metrices\]\[\d+\]/, `[metrices][${i}]`);
        }

        if (inputElement.name.includes("general_transaction_line_credit")){
          inputElement.name = inputElement
            .name
            .replace(/\general_transaction_line_credit\[\d+\]/, `general_transaction_line_credit[${i}]`)
        }

        if (inputElement.name.includes("general_transaction_line_debit")){
          inputElement.name = inputElement
            .name
            .replace(/\general_transaction_line_debit\[\d+\]/, `general_transaction_line_debit[${i}]`)
        }
      });
    }

    const inputElements = Array.prototype.slice.call(
      clonedElement.querySelectorAll('input,select,radio,checkbox,textarea')
    );

    inputElements.forEach((inputElement) => {
      if (inputElement.name.includes("general_transaction_line_credit")){
        inputElement.name = inputElement
          .name
          .replace(/\general_transaction_line_credit\[\d+\]/, `general_transaction_line_credit[${i}]`)
      }

      if (inputElement.name.includes("general_transaction_line_debit")){
        inputElement.name = inputElement
          .name
          .replace(/\general_transaction_line_debit\[\d+\]/, `general_transaction_line_debit[${i}]`)
      }
    });
  }

  generateIndexInMarkdownTextForRequestingElements(){
    for(let i=0; i<this.markdownIndexTargets.length; i++){
      const currentElement = this.markdownIndexTargets[i]
      const markdownTemplate = currentElement.dataset.markdown;
      const value = markdownTemplate.replace(/\#\{i\}/, i+1);
      currentElement.innerHTML = value;
    }
  }
}

