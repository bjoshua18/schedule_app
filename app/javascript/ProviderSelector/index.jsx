import React from 'react'

import NoProvider from './NoProvider';
import TwitterProvider from './TwitterProvider';
import FacebookProvider from './FacebookProvider';


class ProviderSelector extends React.Component {
  constructor(props) {
        super(props);
        this.onProviderSelected = this.onProviderSelected.bind(this);
        this.state = { selectedProvider: null }
  }

  render() {
    let ProviderCustomComponent = NoProvider;
    if (this.state.selectedProvider == "Facebook") {
        ProviderCustomComponent = FacebookProvider
    } else if (this.state.selectedProvider == "Twitter") {
        ProviderCustomComponent = TwitterProvider
    }

    return (
      <div>
        <div className="form-group mb-3">
          <label htmlFor="post_provider">Provider</label>
          <select className="form-control" id="provider" onChange={this.onProviderSelected} name="provider">
            <option value="">Select a provider</option>
            <option value="Facebook">Facebook</option>
            <option value="Twitter">Twitter</option>
          </select>
        </div>
        <ProviderCustomComponent tw_accounts={this.props.tw_accounts} fb_accounts={this.props.fb_accounts}/>
      </div>
    );
  }

  onProviderSelected(event) {
    this.setState({ selectedProvider: event.target.value })
  }
}

export default ProviderSelector
