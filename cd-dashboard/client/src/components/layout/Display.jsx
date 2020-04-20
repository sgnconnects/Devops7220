import React from "react";
import axios from 'axios';
import './Home.css';
import {BrowserRouter as Router, Switch, Route, Link} from "react-router-dom";
import fetch from '../charts/fetch';    
class Display extends React.Component{
    constructor(props) {
    super(props);
    this.state = {           
      posts:[]
    };
   }
    componentDidMount = () => {
      this.getBlogPost();
    };
    
    getBlogPost = () => {
      axios.get('/coins')
        .then((response) => {        
          const data = response.data;
          this.setState({ posts: data });
         // console.log('Data has been received!!');        
        })
        .catch(() => {
          alert('Error retrieving data!!!');
        });
    }
    displayBlogPost = (posts) => {
        if (!posts.length) return null;
        const sortedData = [];
        let count=0;    
        for (var i = 0; i < 1; i++){
      console.log("time stamp",posts[i]);
        for (var j = 0; j < posts[i].chart_timestamps.length-5; j++){ 
          if(posts[i].chart_closes[j]!=null)  {        
         var utcSeconds = posts[i].chart_timestamps[j];
          var d = new Date(0);
          d.setUTCSeconds(utcSeconds);
          d=d.toDateString();
         // d.setMonth(d.getMonth,d.getDate);
         //console.log("date",d);
         var y=posts[i].chart_closes[j];
        //console.log("y",y);
        var getPrice=y.toLocaleString('us-EN',{ style: 'currency', currency: 'USD' });
        //console.log("get Price",getPrice);       
        // console.log("x",x);
        sortedData.push({
            d: d,
            p: getPrice,
            x: count, //previous days
            y: y // numerical price
          });
          count++;
          } else{
            continue;
          } }     
}
     
      return (   
        <div>
          <table className="data-table"> 
          <thead>         
            <tr className="data-row">          
            <th className="data-header">Symbol</th>
            <th className="data-header">Name</th>
            <th className="data-header">Price in $</th>
            <th className="data-header">Change</th>
            <th className="data-header">Market Cap</th>
            <th className="data-header">Volume in Currency</th>
            <th className="data-header">Circulating Supply</th>
            <th className="data-header">1 Day Chart</th>
          </tr>
          </thead>
            <tbody className="data-body">
              {posts.map((post, i) => (                                        
                <tr key={i} className="data-body-row"> 
                  <td className="data-body-data">
                    <img src={post.img} className="data-body-img" alt={post.name}></img>
                  {/*  <a href={'/api/' + post.coin_id} className="data-body-a">{post.acronym}</a> */}
                  {/* <Switch>
                <Route exact path={'/api/' + post.coin_id} children={<fetch {...this.state} />} className="data-body-a"/>
                {post.acronym}
                </Switch> */}
                   <Link to={'/coins/' + post.acronym} className="data-body-a">{post.acronym}</Link>                   
                    <div className="data-body-div"></div>
                    </td>              
                  <td className="data-body-td" arial-label="Name">{post.name}</td> 
                   <td className="data-body-td1">{post.price}</td>
                   <td className="data-body-td1" style={{color: post.change > 0 ? "green" : "red"}}>
                    {post.change}
                    </td>                 
                   <td className="data-body-td">{post.market_cap}</td>
                   <td  className="data-body-td">{post.vol_24h}</td>
                   <td  className="data-body-td">{post.circulating_supply}</td> 
                   <td  className="data-body-td">
                     <img src={post.chart_img} 
                     width="164" height="48" className="data-graph" alt="graph"></img>
                   </td>            
                </tr>
      ))}
            </tbody>
          </table>
        </div>
      );
};  
    render(){       
        return(
          <div className="Home">                        
            <div>
              {this.displayBlogPost(this.state.posts)}            
            </div>            
        </div>
        
    );
    }
}
export default Display;