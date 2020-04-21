import React from 'react';
import Header from "../../Header";
import Footer from "../../Footer";
import Display from "../Display";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import './Home.css';
import fetch from '../../Charts/Fetch';
class Home extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      posts: [],
      table_flag: true,
      chart_flag: false
    };
  }

  render() {
    //JSX
    return (
      <div className="Home">
        <Header />
        <Router>
          <Switch>
            <Route exact path="/" component={Display} />} />
            <Route exact path="/coins/:acronym" component={fetch} />} />
          </Switch>
        </Router>
        <Footer />
      </div>

    );
  }
}
export default Home;