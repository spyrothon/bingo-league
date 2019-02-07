import { h, Component } from 'preact';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

export class RulesScreen extends Component {
  render(props) {
    return (
      <div class="content">
        <h1 class="title header">Rules</h1>

        <p>
          The full ruleset and information about the league is also available in <a href="https://docs.google.com/document/d/14_kh-__sFv1A_08cuwQLg_5-aaLFX29WEpHu0FQPPLM" target="_blank" rel="nofollow noopener">this Google Doc</a>.
        </p>

        <p><strong>Standard Spyro 2 Bingo Rules are as follows:</strong></p>
        <ul>
          <li>You can NOT skip the opening cutscenes, you must watch them through to the end, this is to give players time to look at the board and start planning their routes.</li>

          <li>Races should start from a fresh save file (no starting with fireball (NG+)).</li>
          <li>In-game cheats are not allowed.</li>
          <li>FDS is allowed for NTSC-U, PAL, and NTSC-J.</li>
          <li>Allowed Emulators: ePSXe 1.9.0/1.9.25/2.0.0, Xebra, Mednafen.</li>
          <li>This is lockout, once an objective has been marked off that goal is no longer in play.</li>
          <li>You do not need to mark off goals you have completed immediately but do so at your own risk.</li>
          <li>Live footage is required for all league matches..</li>
          <li>You can use notepads/calculators to note down what you have but it is your responsibility to keep these updated and accurate, mismarked goals without correction will invoke a penalty.</li>
        </ul>

        <p><strong>Important League Rules:</strong></p>
        <ul>
          <li>In the event of a draw (only possible by void goals (note mismarking)) that goal will be singled out and both teams will nominate a player to race each other in a 1 goal shootout for that goal.</li>
          <li>Good sportsmanship is expected from all players, all players should have a form of mutual respect for each other, after all, this is mostly for fun and for messing about in Spyro 2.</li>
          <li>Don’t be needlessly salty about defeats, being salty with the game is fine but if you direct it at players that makes things uncomfortable, too much of this will see you out of the league.</li>
          <li>Keep personal conflicts out of the Spyrothon Discord channel and the Spyrothon Twitch Chat.</li>
          <li>In featured matches you are expected to not stream snipe, stream sniping ruins the main fun of Bingo.</li>
          <li>Goal sniping happens often, it is your responsibility to accept these things happen and to not be excessively angry and upset about it. .</li>
          <li>Just try to have fun with this, this is a good opportunity to make friendships, learn something new about the game or even be introduced to proper speedrunning of Spyro 2.</li>
          <li>If you are unsure about a strat in Spyro 2, feel free to ask people in the league, most of them will know how it works or a method of doing it, we don’t bite (mostly).</li>
          <li>Try to be available as often as possible, you will be warned if you do not do a match within a 10 day time span and kicked from the league if you show inactivity for 15 days, if there is a confliction, please rise this to a moderator ASAP and we will think about getting you a new time slot. If neither Wednesday nor Sunday is suitable for you, don’t sign up cause otherwise you’ll end up holding things up and others could be playing instead.</li>
        </ul>

        <p><strong>Some specific Bingo Rules:</strong></p>
        <ul>
          <li>The Winter Tundra Portal in Dragon Shores does NOT count as a home portal.</li>
          <li>The Fireball Powerup in Dragon Shores does not count towards Powerup types.</li>
          <li>The dual powerup in Metropolis can be used as a unique powerup type.</li>
          <li>Goals containing "gems in X level" means you need to get at least that many gems, you can go over at your leisure.</li>

          <li>Goals containing "combined gems in X and Y" is the sum of gems in those levels.</li>
          <li>Hunter orbs are orbs given to you BY Hunter.</li>
        </ul>

      </div>
    );
  }
};
