import React from "react";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import UserStatisticPage from "./UserStatisticPage/";

const Routes = () => {
  return (
    <Router basename={process.env.REACT_APP_BASE}>
      <Switch>
        <Route exact path="/" component={UserStatisticPage} />
      </Switch>
    </Router>
  );
};

export default Routes;
