import { Divider, Stack, Select, MenuItem, Typography } from "@mui/material";
import { React, useState } from "react";
import User from "./User";

const diceCounts = [1, 2, 4, 8, 16];
const baseUrls = [
  "https://heyinsa.kr/dueldice",
  "https://skyrich3.synology.me:7780/dueldice/dev",
];

const UserstatisticPage = () => {
  const [baseUrl, setBaseUrl] = useState(baseUrls[0]);

  return (
    <>
      <Select
        labelId="demo-simple-select-autowidth-label"
        id="demo-simple-select-autowidth"
        value={baseUrl}
        onChange={(event) => setBaseUrl(event.target.value)}
        autoWidth
        label="baseUrl"
      >
        {baseUrls.map((e) => {
          return (
            <MenuItem value={e} key={e}>
              <Typography>{e}</Typography>
            </MenuItem>
          );
        })}
      </Select>
      <Stack
        direction="row"
        divider={<Divider orientation="vertical" flexItem />}
      >
        {diceCounts.map((diceCount, index) => {
          return <User baseUrl={baseUrl} diceCount={diceCount} key={index} />;
        })}
      </Stack>
    </>
  );
};

export default UserstatisticPage;
