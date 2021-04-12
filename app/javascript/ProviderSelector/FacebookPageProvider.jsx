import React from 'react'

class FacebookPageProvider extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    let options_pages = new Array();
    for (let i = 0; i<this.props.pages.length; i++) {
        options_pages.push(<option value={this.props.pages[i]._id["$oid"]}>{this.props.pages[i].name}</option>)
    }

    return (
        <div className="form-group mb-3">
            <label htmlFor="post_fb_user_page">
                Facebook User Page
            </label>
            <select className="form-control" id="post_publisher_id" name="post[publisher_id]">
                <option value="">Select a page</option>
                {options_pages}
            </select>
        </div>
    );
  }
}

export default FacebookPageProvider