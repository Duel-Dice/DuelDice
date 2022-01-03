import { React, useState, useEffect } from "react";
import {
  Stack,
  List,
  ListItem,
  Accordion,
  AccordionSummary,
  AccordionDetails,
  Typography,
} from "@mui/material";
import ExpandMoreIcon from "@mui/icons-material/ExpandMore";
import axios from "axios";

const User = ({ baseUrl, diceCount }) => {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    const url = `${baseUrl}/api/statistics/users/${diceCount}`;

    axios
      .get(url)
      .then((response) => {
        setUsers(
          response.data.sort(function (a, b) {
            return new Date(b.createdAt) - new Date(a.createdAt);
          })
        );
      })
      .catch((error) => {
        console.log(`${url} 호출 실패!`);
      });
  }, [baseUrl, diceCount]);

  return (
    <Stack sx={{ width: "100%", maxWidth: 200, bgcolor: "background.paper" }}>
      <Typography
        variant="h6"
        component="div"
        gutterBottom
        sx={{ textAlign: "center" }}
      >
        User {diceCount}
      </Typography>
      <List>
        {users.map((user, index) => {
          return (
            <ListItem key={index}>
              <Accordion style={{ width: "100%" }}>
                <AccordionSummary
                  expandIcon={<ExpandMoreIcon />}
                  aria-controls="panel1a-content"
                  id="panel1a-header"
                >
                  <Typography>{user.nickname}</Typography>
                </AccordionSummary>
                <AccordionDetails>
                  <div
                    style={{
                      display: "flex",
                      flexDirection: "column",
                    }}
                  >
                    <pre>{JSON.stringify(user, null, 2)}</pre>
                    <br />
                    {/* <DetailMenu
                      clickHandler={() => {
                        setUserId(user.user_id);
                      }}
                    /> */}
                  </div>
                </AccordionDetails>
              </Accordion>
            </ListItem>
          );
        })}
      </List>
    </Stack>
  );
};

export default User;
