import React, { Component } from 'react';
import './InfoBox.css';
import axios from 'axios';
class InfoBox extends Component {
  constructor(props) {
    super(props);
    this.state = {
      currentPrice: null,
      monthChangeD: null,
      monthChangeP: null,
      updatedAt: null,
      posts: []
    }
  }
  componentDidMount() {
    this.getData = () => {
      const { data } = this.props;
      const url_data = window.location.pathname;
      const coin_id = url_data.substring(7, url_data.length);
      axios.get(process.env.REACT_APP_API_HOST + `/coins/${coin_id}`)
      // axios.get(`/coins/${coin_id}`)
        .then((response) => {
          const posts = response.data;
          this.setState({ posts: posts });

          console.log("posts info box", posts);
          const current = posts.price.replace(",", "");
          const p = ((current - data[0].y));
          console.log("data", p);
          const price = posts.price;
          const change = p;
          const changeP = (p) / data[0].y * 100;
          console.log("price", price);
          console.log("change", change);
          console.log("changep", changeP);
          this.setState({
            currentPrice: (current - 0).toLocaleString('us-EN', { style: 'currency', currency: 'USD' }),
            monthChangeD: change.toLocaleString('us-EN', { style: 'currency', currency: 'USD' }),
            monthChangeP: changeP.toFixed(2) + '%'
          })
        })
        .catch(() => {
          alert('Error retrieving data!!!');
        });
    }

    this.getData();
    this.refresh = setInterval(() => this.getData(), 90000);
  }

  componentWillUnmount() {
    clearInterval(this.refresh);
  }
  render() {
    return (
      <div id="data-container">
        {this.state.currentPrice ?
          <div id="left" className='box'>
            <div className="heading">{this.state.currentPrice.toLocaleString('us-EN', { style: 'currency', currency: 'USD' })}</div>
            <div className="subtext">Current Price Updated Just Now</div>
          </div>
          : null}
        {this.state.currentPrice ?
          <div id="middle" className='box'>
            <div className="heading">{this.state.monthChangeD}</div>
            <div className="subtext">Change Since Last Month (USD)</div>
          </div>
          : null}
        <div id="right" className='box'>
          <div className="heading">{this.state.monthChangeP}</div>
          <div className="subtext">Change Since Last Month (%)</div>
        </div>

      </div>
    );
  }
}

export default InfoBox;