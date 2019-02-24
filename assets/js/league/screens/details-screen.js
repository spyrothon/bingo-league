import { h, Component } from 'preact';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

export class DetailsScreen extends Component {
  render(props) {
    return (
      <div class="content">
        <div class="columns is-multiline has-margin-top-lg">
          <div class="column is-6">
            <h1 class="title header">League Overview</h1>

            <p>The Spyrothon Bingo League will host featured matches on the <a href="https://twitch.tv/spyrothon" target="_blank" rel="nofollow noopener">Spyrothon Twitch Channel</a>. Check the Match Schedule to see which matches will be featured and when those matches will be played.</p>

            <p>Join the <a href="https://discord.gg/fCvfnfk" target="_blank" rel="nofollow noopener">Spyrothon Discord Server</a> to hang out, ask any questions, and keep up with the league as it happens!</p>
          </div>

          <div class="column is-6">
            <h1 class="title header">Prizes</h1>

            <p>A total prize pool of $250 is available, distributed as follows:</p>

            <ul>
              <li>$120 for First in the top 4 playoffs</li>
              <li>$60 for Second in the top 4 playoffs</li>
              <li>$30 for Third in the top 4 playoffs</li>
              <li>$40 for the leader of the overall league table</li>
            </ul>
          </div>

          <div class="column is-6">
            <h1 class="title header">Important Dates</h1>

            <ul>
              <li><strong>7th February - 21st February</strong><br /> Submissions open</li>
              <li><strong>21st February</strong><br /> Teams are pooled into the league, practice time.</li>
              <li><strong>1st March - TBD</strong><br /> Main League (catchup time to be added)</li>
              <li><strong>To be confirmed</strong><br /> Playoffs</li>
            </ul>
          </div>

          <div class="column is-6">
            <h1 class="title header">Match Dates</h1>

            <p>Matches will be held on Wednesdays and Sundays in one of 5 time slots, depending on players' availability.</p>

            <table class="table is-fullwidth">
              <thead>
                <tr>
                  <th>Start</th>
                  <th>End</th>
                </tr>
              </thead>

              <tbody>
                <tr>
                  <td>6:00 PM UTC</td>
                  <td>7:15 PM UTC</td>
                </tr>
                <tr>
                  <td>7:30 PM UTC</td>
                  <td>8:45 PM UTC</td>
                </tr>
                <tr>
                  <td>9:00 PM UTC</td>
                  <td>10:15 PM UTC</td>
                </tr>
                <tr>
                  <td>10:30 PM UTC</td>
                  <td>11:45 PM UTC</td>
                </tr>
                <tr>
                  <td>12:00 AM UTC</td>
                  <td>01:15 AM UTC</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    );
  }
};
