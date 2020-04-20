import React from 'react';
import Header from "../header/Header";
import Footer from "../footer/Footer";
import Display from "./Display";
import {BrowserRouter as  Router, Switch, Route} from "react-router-dom";
import './Home.css';
import fetch from '../charts/fetch';
class Home extends React.Component{
  constructor(props) {
  super(props);
  this.state = {           
    posts:[],
    table_flag:true,
    chart_flag:false
  };
 }
  /* componentDidMount = () => {
    this.getBlogPost();
  };
  
  getBlogPost = () => {
    axios.get('/api')
      .then((response) => {        
        const data = response.data;
        this.setState({ posts: data });
        console.log('Data has been received!!');        
      })
      .catch(() => {
        alert('Error retrieving data!!!');
      });
  } */
  /* displayBlogPost = (posts) => {

    if (!posts.length) return null;    
    for (var i = 0; i < 2; i++){
   console.log("time stamp",posts[i]);
    for (var j = 0; j < 2; j++){
    //console.log("posts[i].chart_timestamps[j]",posts[i].chart_timestamps[j]);    
     var utcSeconds = posts[i].chart_timestamps[j];
      var d = new Date(0);
      d.setUTCSeconds(utcSeconds);    
     // console.log("date",d);
      }
    }
   
    return (      
      <div>
        <table className="data-table">          
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
          <tbody className="data-body">
            {posts.map((post, i) => (                                        
              <tr key={i} className="data-body-row"> 
                <td className="data-body-data">
                  <img src={post.img} className="data-body-img" alt={post.name}></img>
                  <a href={'/api/' + post._id} className="data-body-a">{post.acronym}</a>
                  <div class="data-body-div"></div>
                  </td>              
                <td colSpan className="data-body-td" arial-label="Name">{post.name}</td> 
                 <td colSpan className="data-body-td1">{post.price}</td>
                 <td colSpan className="data-body-td1" style={{color: post.change > 0 ? "green" : "red"}}>
                  {post.change}
                  </td>                 
                 <td colSpan className="data-body-td">{post.market_cap}</td>
                 <td colSpan className="data-body-td">{post.vol_24h}</td>
                 <td colSpan className="data-body-td">{post.circulating_supply}</td> 
                 <td colSpan className="data-body-td">
                   <img src={post.chart_img} 
                   width="164" height="48" className="data-graph" alt="graph"></img>
                 </td>            
              </tr>
    ))}
          </tbody>
        </table>
      </div>
    );
  };  */ 
  render(){
    //JSX
    return(
      <div className="Home">
      <Header/>
      <Router>      
         {/*  <Display/> */}
          <Switch>
           <Route exact path="/" component={Display} />} />
            <Route exact path="/coins/:acronym" component={fetch} />} />            
          </Switch>
        </Router>      
        {/* <div>
          {this.displayBlogPost(this.state.posts)}
        </div>  */}
        <Footer />   
    </div>
    
);
  }
}
export default Home;