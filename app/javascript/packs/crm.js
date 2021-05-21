Crm = {};

Crm.utils = {};
Crm.utils.makeAjax = null;
Crm.utils.formValidator = null;
Crm.utils.formSerializer = null;
Crm.utils.formDeSerializer = null;

Crm.utils.jsonDeserializer = null;

Crm.events = {};
Crm.events.callbacks = { onLoaded: {} };
Crm.events.onLoaded = null;
Crm.events.forceCallOnLoaded = null;

Crm.oneTimeKeystore = null;

Crm.hashcode = null;

Crm.utils.makeAjax = function(url, method, dataType, data, callbacks) {
  callbacks.before();
  $.ajax({
    url: url,
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    type: method,
    data: data,
    dataType: dataType,
    success: function(result){
      callbacks.after(result);
    }
  });
};

// args: formSelector(JS), callback (run if form is valid)}
Crm.utils.formValidator = function(formSelector, valid) {
  if(formSelector.checkValidity()) {
    valid();
    return;
  }
  formSelector.reportValidity();
};

// args: element(Jquery), returns: Array of data-serializable elements
Crm.utils.formSerializer = function(element) {
  let serializedArray = [];
  element.find('[data-serializable]').each(function() {
    serializedArray.push({name: $(this).data('serializable'), value: $(this).val()})
  });
  return serializedArray;
};

// args: element(Jquery)
Crm.utils.formDeSerializer = function(element, serializedArray) {
  serializedArray.forEach((serialized) => {
    element.find(`[data-serializable='${serialized.name}']`).val(serialized.value);
  });
};

Crm.utils.jsonDeserializer = function(string) {
  return JSON.parse(string);
};
Object.defineProperty(String.prototype, 'deserialize', {
  get: function() {
    return Crm.utils.jsonDeserializer(this);
  }
});

// register callback without duplication
Crm.events.onLoaded = function(callback) {
  Crm.events.callbacks.onLoaded[Crm.hashcode(callback.toString())] = callback;
};

Crm.oneTimeKeystore = {
  map: {},
  write: function(key, value) {
    this.map[key] = value;
  },
  read: function(key) {
    let val = this.map[key];
    delete this.map[key];
    return val;
  },
  clear: function(){
    this.map = {};
  }
};

Crm.hashcode = function(s){
  return s.split("").reduce(function(a,b){a=((a<<5)-a)+b.charCodeAt(0);return a&a},0);
};

Crm.events.forceCallOnLoaded = function() {
  for(let callbackHashCode in Crm.events.callbacks.onLoaded) {
    Crm.events.callbacks.onLoaded[callbackHashCode]();
  }
};

$(document).on('turbolinks:load ajaxComplete ajax:complete', function() {
  Crm.events.forceCallOnLoaded();
});
