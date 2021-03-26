import React from 'react'
import ReactDOM from 'react-dom'
import ProviderSelector from 'ProviderSelector'

document.addEventListener('turbolinks:load', () => {
  let element = document.getElementById('provider');

  if (element) {
    let tw_accounts = JSON.parse(element.getAttribute('tw_accounts'));
    let fb_accounts = JSON.parse(element.getAttribute('fb_accounts'));

    console.log(tw_accounts);

    ReactDOM.render(
      <ProviderSelector tw_accounts={tw_accounts} fb_accounts={fb_accounts}/>, 
      element
    );
  }
});