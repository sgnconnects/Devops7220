import React, { Component } from 'react';
import './fetch.css';
import LineChart from './LineChart';
import ToolTip from './ToolTip';
import InfoBox from './InfoBox';
import axios from 'axios';
class fetch extends Component {
  constructor(props) {
    super(props);
    this.state = {
      fetchingData: true,
      data: null,
      hoverLoc: null,
      activePoint: null,
      name:null,
      market_cap:null,
      vol_24h:null,
      circulating_supply:null,
      about:null
    }
  }
  handleChartHover(hoverLoc, activePoint){
    this.setState({
      hoverLoc: hoverLoc,
      activePoint: activePoint
    })
  }
  componentDidMount(){
    const getData = () => {
      const url_data = window.location.pathname;
      const coin_id=url_data.substring(7,url_data.length);
      console.log("coin_id",coin_id);   
      axios.get(`/coins/${coin_id}`)
        .then((response) => {        
          var posts = response.data;
          this.state.name=posts.name;
          this.state.market_cap=posts.market_cap;
          this.state.circulating_supply=posts.circulating_supply;
          this.state.vol_24h=posts.vol_24h;
          this.state.about=posts.about;
          console.log('Data has been received for chart!!',posts);
         // this.setState({ posts: response.data });
          //console.log('Data has been received for chart!!',posts);
          const sortedData = [];
          let count = 0;             
          for (var i = 0; i < 1; i++){
          //console.log("posts",posts[i]);
          for(var j=0;j<response.data.chart_timestamps.length;j++){
            if(response.data.chart_closes[j]!=null){
            var utcSeconds = response.data.chart_timestamps[j];
            var d = new Date(0);
            d.setUTCSeconds(utcSeconds);
            d=d.toDateString();
            var y=response.data.chart_closes[j];
            //console.log("y",y);
            var getPrice=y.toLocaleString('us-EN',{ style: 'currency', currency: 'USD' });      
            sortedData.push({
            d: d,
            p: getPrice,
            x: count, //previous days
            y: y // numerical price
            });
            count++;
           } else{
            continue;
          }
          }
          this.setState({
            data: sortedData,
            fetchingData: false
          })
         console.log("data",this.state.data);
      }
        })
        .catch((e) => {
          console.log(e);
        });
    }
    getData();
}
 render() {
    return (

      <div className='container'>       
      <div className='row'>
    <h1>30 Days <u>{this.state.name}</u> Price Chart</h1>
        </div>        
        <div className='row'>
          { !this.state.fetchingData ?
          <InfoBox data={this.state.data} />
          : null }
        </div>
        <div className='row'>
          <div className='popup'>
            {this.state.hoverLoc ? <ToolTip hoverLoc={this.state.hoverLoc} activePoint={this.state.activePoint}/> : null}
          </div>
        </div>
        <div className='row'>
          <div className='chart'>
            { !this.state.fetchingData ?
              <LineChart data={this.state.data} onChartHover={ (a,b) => this.handleChartHover(a,b) }/>
              : null }
          </div>
        </div>   
        <hr></hr>
           <div className="about">
              <div className="about-head">
                  <div className="about-head-data">
                      <label className="about-head-label">
                        Name                        
                        <span className="symbol-space">
                          &nbsp;
                          <span className="tooltip">
                              &#9432;
                              <span className="tooltiptext">
                                Cryptocurrency Name
                              </span>
                           </span>
                        </span>
                        </label>
                  </div>
                  <h6 className="about-subhead">{this.state.name}</h6>
              </div>
              <div className="about-head">
                  <div className="about-head-data">
                      <label className="about-head-label">
                        Market cap                        
                        <span className="symbol-space">
                          &nbsp;
                          <span className="tooltip">
                              &#9432;
                              <span className="tooltiptext">
                                The current price of <span>{this.state.name}</span> 
                                &nbsp;multiplied by its current circulating supply.
                              </span>
                           </span>
                        </span>
                        </label>
                  </div>
                  <h6 className="about-subhead">{this.state.market_cap}</h6>
              </div>
              <div className="about-head">
                  <div className="about-head-data">
                      <label className="about-head-label">
                        Volume (24 hours)                        
                        <span className="symbol-space">
                          &nbsp;
                          <span className="tooltip">
                              &#9432;
                              <span className="tooltiptext">
                                The total dollar value of all <span>{this.state.name}</span>
                                &nbsp; transactions over the past 24 hours.
                              </span>
                           </span>
                        </span>
                        </label>
                  </div>
                  <h6 className="about-subhead">{this.state.vol_24h}</h6>
              </div>
              <div className="about-head">
                  <div className="about-head-data">
                      <label className="about-head-label">
                        Circulating supply                      
                        <span className="symbol-space">
                          &nbsp;
                          <span className="tooltip">
                              &#9432;
                              <span className="tooltiptext">
                                The amount of <span>{this.state.name}</span>&nbsp; that 
                                is currently liquid and in circulation.
                              </span>
                           </span>
                        </span>
                        </label>
                  </div>
                  <h6 className="about-subhead">{this.state.circulating_supply}</h6>
              </div>
             </div>  
             <div className="style-container">
               <div className="style-description">
                <h2 className="text-element">
              About <span>{this.state.name}</span>
                </h2>
                <div className="style-description-text">
                  <p className="text-para">
{this.state.about}
                  </p>
                </div>
               </div>
               </div> 
      </div>       

    );
  }
}

export default fetch;
