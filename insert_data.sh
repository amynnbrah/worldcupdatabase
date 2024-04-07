#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE TABLE games, teams")

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if [[ $YEAR != year ]]
then
#get winner ID from teams
WINNER_ID=$($PSQL "select team_id from teams where name = '$WINNER'")
#if winner is not in teams
if [[ -z $WINNER_ID ]]
#add winner
then
INSERT_WINNER=$($PSQL "insert into teams(name) values ('$WINNER')")
fi
#get opponent ID from teams
OPPONENT_ID=$($PSQL "select team_id from teams where name = '$OPPONENT'")
if [[ -z $OPPONENT_ID ]]
then
INSERT_OPPONENT=$($PSQL "insert into teams(name) values('$OPPONENT')")
fi
WINNER_ID2=$($PSQL "select team_id from teams where name = '$WINNER'")
OPPONENT_ID2=$($PSQL "select team_id from teams where name = '$OPPONENT'")

INSERT_GAMES=$($PSQL "insert into games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) values('$YEAR', '$ROUND', '$WINNER_ID2', '$OPPONENT_ID2', '$WINNER_GOALS', '$OPPONENT_GOALS')")

fi
done