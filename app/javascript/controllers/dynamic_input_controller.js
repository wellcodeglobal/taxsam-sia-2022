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
    while(inputElement.dataset.target !== 'dynamic-input.element'){
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
      '([data-dynamic-input-exclude-clearing="1"])',
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
      this.element.querySelectorAll('input[data-dynamic-input-respect-id="1"],select[data-dynamic-input-respect-id="1"]')
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

        if (inputElement.name.includes("tax_items")){
          inputElement.name = inputElement
            .name
            .replace(/tax_items\[\d+\]/, `[tax_items][${i}]`);
        }

        if (inputElement.name.includes("general_transaction_line")){
          inputElement.name = inputElement
            .name
            .replace(/\general_transaction_line\[\d+\]/, `general_transaction_line[${i}]`)
        }

        if (inputElement.name.includes("general_transaction_line_credit")){
          inputElement.name = inputElement
            .name
            .replace(/\general_transaction_line_credit\[\d+\]/, `general_transaction_line_credit[${i}]`)
        }
      });
    }

    const inputElements = Array.prototype.slice.call(
      clonedElement.querySelectorAll('input,select,radio,checkbox,textarea')
    );

    inputElements.forEach((inputElement) => {
      if (inputElement.name.includes("metrices")){
        inputElement.name = inputElement
          .name
          .replace(/\[metrices\]\[\d+\]/, `[metrices][${i}]`);
      }

      if (inputElement.name.includes("tax_items")){
        inputElement.name = inputElement
          .name
          .replace(/tax_items\[\d+\]/, `[tax_items][${i}]`);
      }

      if (inputElement.name.includes("general_transaction_line")){
        inputElement.name = inputElement
          .name
          .replace(/\general_transaction_line\[\d+\]/, `general_transaction_line[${i}]`)

        if(inputElement.dataset.card){
          const cardElement = document.querySelector(inputElement.dataset.card)
          const cashAccountElement = cardElement.querySelector('select[name="general_transaction[cash_account_id]"]');
          const cashAccountSelectedItem = cashAccountElement.options[cashAccountElement.selectedIndex].text;

          if(cashAccountSelectedItem.includes('USD') || cashAccountSelectedItem.includes('507') || cashAccountSelectedItem.includes('096')){
            if (inputElement.name ==`general_transaction_line[${i}][price]`) {
              inputElement.readOnly = true
              inputElement.value = 0
            }
            if (inputElement.name ==`general_transaction_line[${i}][price_with_exchange_rate]`) {
              inputElement.readOnly = false
              inputElement.value = 0
            }
          } else {
            if (inputElement.name ==`general_transaction_line[${i}][price]`) {
              inputElement.readOnly = false
              inputElement.value = 0
            }
            if (inputElement.name ==`general_transaction_line[${i}][price_with_exchange_rate]`) {
              inputElement.readOnly = true
              inputElement.value = 0
            }
          }
          if(cardElement.querySelector('input[name="taxes"]').checked && inputElement.name ==`general_transaction_line[${i}][tax_account_id]`){
            inputElement.parentElement.parentElement.parentElement.classList.remove('d-none')
            inputElement.setAttribute("required", "")
          }
          if(cardElement.querySelector('input[name="taxes"]').checked && inputElement.name ==`general_transaction_line[${i}][tax_description]`){
            inputElement.setAttribute("required", "")
          }

          const selectedTaxElement = cardElement.querySelector('select[name="tax_items[0][tax_rate_id]"');

          if (selectedTaxElement.value != ''){
            const selectedOptGroupText = selectedTaxElement.options[selectedTaxElement.selectedIndex].parentElement.label;
            if(inputElement.name == `general_transaction_line[${i}][tax_price]`){
              if(selectedOptGroupText == 'Ppn'){
                inputElement.parentElement.previousElementSibling.querySelector('.js-tax-label').innerHTML =  '<strong>Nominal PPN</strong>'
              } else {
                inputElement.parentElement.previousElementSibling.querySelector('.js-tax-label').innerHTML =  '<strong>Nominal Put-Pot</strong>'
              }
            }
          }
        }
      }

      if (inputElement.name.includes("general_transaction_line_credit")){
        inputElement.name = inputElement
          .name
          .replace(/\general_transaction_line_credit\[\d+\]/, `general_transaction_line_credit[${i}]`)
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
