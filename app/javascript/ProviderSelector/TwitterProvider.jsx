import React from 'react'

class TwitterProvider extends React.Component {
  constructor(props) {
    super(props);
    console.log(props.tw_accounts)
  }

  render() {
    let options = new Array();
    for (let i = 0; i<this.props.tw_accounts.length; i++) {
      options.push(<option value={this.props.tw_accounts[i]._id["$oid"]}>{this.props.tw_accounts[i].username}</option>)
    }

    return (
      <div>
        <div className="form-group mb-3">
          <label htmlFor="post_twitter_account_id">
            Twitter User
          </label>
          <select className="form-control" id="post_twitter_account_id" name="post[twitter_account_id]">
            <option value="">Select an user</option>
            {options}
          </select>
        </div>
      </div>
    );
  }
}

export default TwitterProvider