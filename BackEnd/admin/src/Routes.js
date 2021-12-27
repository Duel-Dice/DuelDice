import React from "react";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import UserStaticsPage from "./UserStaticsPage/";

const Routes = () => {
  return (
    <Router basename={process.env.REACT_APP_BASE}>
      <Switch>
        <Route exact path="/" component={UserStaticsPage} />
      </Switch>
    </Router>
  );
};

export default Routes;
