import React from 'react';
import axios from 'axios';


import './App.css';

class App extends React.Component{

  state = {
    id: '',
    name: '',
    price: '',
    posts:[]
  };

  componentDidMount = () => {
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
  }
  displayBlogPost = (posts) => {

    if (!posts.length) return null;
    /* return posts.map((post, index) => (
     // <div key={index} >
      //  <h3>{post.name}</h3>
       // <p>{post.price}</p>
       <div>
        <table border="2" className="data-table">
          <caption style={{fontWeight: "bold", fontSize: "15px"}}>Cryptocurrencies</caption>
          <tbody>           
              <tr key={index}>               
                 <td>{post.name}</td> 
                 <td>{post.price}</td>             
              </tr>            
          </tbody>
        </table>
      </div>
    )); */
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
        </tr>
          <tbody className="data-body">
            {posts.map((post, i) => (
              <tr key={i} className="data-body-row">  
                <td className="data-body-data">
                  <img src={post.img} className="data-body-img" alt={post.name}></img>
                  <a href="/quote" className="data-body-a">{post.acronym}</a>
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
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    );
  };
  render(){
    //JSX
    return(
      <div className="App">
        <header className="App-header">
        <h2>Cryptocurrency Dashboard</h2></header>
        <div>
          {this.displayBlogPost(this.state.posts)}
        </div>
      </div>   
      
);
  }
}
export default App;