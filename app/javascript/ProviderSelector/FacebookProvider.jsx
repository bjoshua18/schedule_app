import React from 'react'

import FacebookPageProvider from './FacebookPageProvider';
import NoUser from './NoUser'

class FacebookProvider extends React.Component {
  constructor(props) {
    super(props);
    this.onUserSelected = this.onUserSelected.bind(this);
    this.state = { selectedUser: null }
  }

  render() {
    let options_users = new Array();
    let pages = new Array();
    for (let i = 0; i<this.props.fb_accounts.length; i++) {
      options_users.push(<option value={this.props.fb_accounts[i].name}>{this.props.fb_accounts[i].name}</option>)
    }

    let UserCustomComponent = NoUser;

    if (this.state.selectedUser != "" && this.state.selectedUser != null) {
      UserCustomComponent = FacebookPageProvider;

      for (let i = 0; i<this.props.fb_accounts.length; i++) {
        if (this.state.selectedUser == this.props.fb_accounts[i].name) {
          pages = this.props.fb_accounts[i].pages;
        }
      }
    }

    return (
      <div>
        <div>
          <div className="form-group mb-3">
            <label htmlFor="post_facebook_account_id">
              Facebook User
            </label>
            <select className="form-control" id="facebook_account" onChange={this.onUserSelected} name="facebook_account">
              <option value="">Select an user</option>
              {options_users}
            </select>
          </div>
          <UserCustomComponent pages={pages}/>
        </div>
      </div>
    );
  }

  onUserSelected(event) {
    this.setState({ selectedUser: event.target.value })
  }
}

export default FacebookProvider