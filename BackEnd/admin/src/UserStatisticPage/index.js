import { React } from "react";
import Divider from "@mui/material/Divider";
import Stack from "@mui/material/Stack";
import User from "./User";

const dice_counts = [1, 2, 4, 8, 16];

const UserstatisticPage = () => {
  return (
    <Stack
      direction="row"
      divider={<Divider orientation="vertical" flexItem />}
    >
      {dice_counts.map((dice_count, index) => {
        return <User dice_count={dice_count} key={index} />;
      })}
    </Stack>
  );
};

export default UserstatisticPage;
