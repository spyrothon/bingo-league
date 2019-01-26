import { h, Component } from 'preact';

class TeamStandings extends Component {
  render(props) {
    const {
      teamsById,
      matchesById,
      playsById
    } = props;

    const teams = Object.values(teamsById)
        .sort((a, b) => b.total_score - a.total_score);
    const matches = Object.values(matchesById);
    const plays = Object.values(playsById);

    return (
      <ul>
        { teams.map((team, index) => {
            return (
              <li>
                <div class="team-ranking">
                  <div class="columns is-mobile">
                    <div class="column is-narrow">
                      <span class="has-text-weight-bold has-text-grey">{index + 1}</span>
                    </div>
                    <div class="column">
                      <p class="team-ranking-name"><a href={`/teams/${team.id}`}>{team.name}</a></p>
                      <p class="has-text-grey">{team.wins} wins &ndash; {team.losses} losses</p>
                    </div>
                    <div class="column is-narrow has-text-right">
                      <p class="has-text-weight-bold">{team.total_score}</p>
                    </div>
                  </div>
                </div>
              </li>
            );
          })
        }
      </ul>
    );
  }
}

export default TeamStandings;
