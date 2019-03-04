export function bingoGenerator(bingoList, { lang = 'name', mode = 'normal' }) {
    const seed = Math.ceil(999999 * Math.random()).toString();
    const size = 5;
    const rowCheckList = [];
    const rowElements = {};
    var bingoBoard = []; //the board itself stored as an array first

    Math.seedrandom(seed); //sets up the RNG

    if(size == 5) {
      rowElements["row1"] = [1,2,3,4,5];
      rowElements["row2"] = [6,7,8,9,10];
      rowElements["row3"] = [11,12,13,14,15];
      rowElements["row4"] = [16,17,18,19,20];
      rowElements["row5"] = [21,22,23,24,25];
      rowElements["col1"] = [1,6,11,16,21];
      rowElements["col2"] = [2,7,12,17,22];
      rowElements["col3"] = [3,8,13,18,23];
      rowElements["col4"] = [4,9,14,19,24];
      rowElements["col5"] = [5,10,15,20,25];
      rowElements["tlbr"] = [1,7,13,19,25];
      rowElements["bltr"] = [5,9,13,17,21];

      rowCheckList[1] = ["row1","col1","tlbr"];
      rowCheckList[2] = ["row1","col2"];
      rowCheckList[3] = ["row1","col3"];
      rowCheckList[4] = ["row1","col4"];
      rowCheckList[5] = ["row1","col5","bltr"];

      rowCheckList[6] = ["row2","col1"];
      rowCheckList[7] = ["row2","col2","tlbr"];
      rowCheckList[8] = ["row2","col3"];
      rowCheckList[9] = ["row2","col4","bltr"];
      rowCheckList[10] = ["row2","col5"];

      rowCheckList[11] = ["row3","col1"];
      rowCheckList[12] = ["row3","col2"];
      rowCheckList[13] = ["row3","col3","tlbr","bltr"];
      rowCheckList[14] = ["row3","col4"];
      rowCheckList[15] = ["row3","col5"];

      rowCheckList[16] = ["row4","col1"];
      rowCheckList[17] = ["row4","col2","bltr"];
      rowCheckList[18] = ["row4","col3"];
      rowCheckList[19] = ["row4","col4","tlbr"];
      rowCheckList[20] = ["row4","col5"];

      rowCheckList[21] = ["row5","col1","bltr"];
      rowCheckList[22] = ["row5","col2"];
      rowCheckList[23] = ["row5","col3"];
      rowCheckList[24] = ["row5","col4"];
      rowCheckList[25] = ["row5","col5","tlbr"];
    }

    function difficulty(i) {
      // To create the magic square we need 2 random orderings of the numbers 0, 1, 2, 3, 4.
      // The following creates those orderings and calls them table2 and table1

      var num3 = seed%1000; // table2 will use the ones, tens, and hundreds digits.

      var rem8 = num3%8;
      var rem4 = Math.floor(rem8/2);
      var rem2 = rem8%2;
      var rem5 = num3%5;
      var rem3 = num3%3;  // Note that rem2, rem3, rem4, and rem5 are mathematically independent.
      var remT = Math.floor(num3/120);  // This is between 0 and 8

      // The idea is to begin with an array containing a single number, 0.
      // Each number 1 through 4 is added in a random spot in the array's current size.
      // The result - the numbers 0 to 4 are in the array in a random (and uniform) order.
      var table2 = [0];
      var table1 = [0];
      table2.splice(rem2, 0, 1);
      table2.splice(rem3, 0, 2);
      table2.splice(rem4, 0, 3);
      table2.splice(rem5, 0, 4);

      num3 = Math.floor(seed/1000); // table1 will use the next 3 digits.
      num3 = num3%1000;

      rem8 = num3%8;
      rem4 = Math.floor(rem8/2);
      rem2 = rem8%2;
      rem5 = num3%5;
      rem3 = num3%3;
      remT = remT * 8 + Math.floor(num3/120);  // This is between 0 and 64.

      table1.splice(rem2, 0, 1);
      table1.splice(rem3, 0, 2);
      table1.splice(rem4, 0, 3);
      table1.splice(rem5, 0, 4);

      i--;
      remT = remT%5;    //  Between 0 and 4, fairly uniformly.
      const x = (i+remT)%5;   //  remT is horizontal shift to put any diagonal on the main diagonal.
      const y = Math.floor(i/5);

      // The Tables are set into a single magic square template
      // Some are the same up to some rotation, reflection, or row permutation.
      // However, all genuinely different magic squares can arise in this fashion.
      var e5 = table2[(x + 3*y)%5];
      var e1 = table1[(3*x + y)%5];

      // table2 controls the 5* part and table1 controls the 1* part.
      let value = 5*e5 + e1;

      if (mode == "short") { value = Math.floor(value/2); } // if short mode, limit difficulty
      else if (mode == "long") { value = Math.floor((value + 25) / 2); }
      value++;
      return value;
    }

    //Uniformly shuffles an array (note: the original array will be changed)
    function shuffle(toShuffle) {
      for(var i=0; i < toShuffle.length; i++) {
        var randElement = Math.floor(Math.random()*(i+1));
        var temp = toShuffle[i];
        toShuffle[i] = toShuffle[randElement];
        toShuffle[randElement] = temp;
      }
    }

    //Get a uniformly shuffled array of all the goals of a given difficulty tier
    function getShuffledGoals(bingoList, difficulty) {
      var newArray = bingoList[difficulty-1].slice();
      shuffle(newArray);
      return newArray;
    }

    //Given a difficulty as an argument, find the square that contains that difficulty
    function getDifficultyIndex(difficulty) {
      for(var i=1; i <= 25; i++) {
        if(bingoBoard[i].difficulty == difficulty) {
          return i;
        }
      }
      return 0;
    }

    function checkLine(i, testsquare) {
        var boardTypesA = testsquare.boardtypes || [];
        var boardSynergy = 0;
        // first check boardtypes synergy, which is per board
        for(var b_i = 1; b_i <= 25; b_i++) {
          var boardTypesB = bingoBoard[b_i].boardtypes || [];
          // check for any overlap
          for(var i_a = 0; i_a < boardTypesA.length; i_a++) {
            for(var i_b = 0; i_b < boardTypesB.length; i_b++) {
              // If a boardtype matches, use a high synergy to try to force abort
              if (boardTypesA[i_a] == boardTypesB[i_b]) {
                boardSynergy += 5;
              }
            }
          }
        }
        if (boardSynergy !== 0) {
          return boardSynergy;
        }

        // then check for "types" synergy, which is per row
        var typesA = testsquare.types || [];
        var synergy = 0;
        var rows = rowCheckList[i], elements = [];
        for(var k=0; k < rows.length; k++) {
          elements = rowElements[rows[k]];
          for(var m=0; m < elements.length; m++) {
            var typesB = bingoBoard[elements[m]].types;
            if(typeof typesB != 'undefined') {
              for(var n=0; n < typesA.length; n++) {
                for(var p=0; p < typesB.length; p++) {
                  if(typesA[n] == typesB[p]) {
                    synergy++; //if match increase
                    if(n==0) { synergy++ }; //if main type increase
                    if(p==0) { synergy++ }; //if main type increase
                  }
                }
              }
            }
          }
        }
        return synergy;
    }


    for(var i=1;i<=25;i++) {
      if(mode == "short") {
        bingoBoard[i] = {difficulty: difficulty(i), child: "yes"};
      }
      else {
        bingoBoard[i] = {difficulty: difficulty(i), child: "no"};
      }
    }                                          // in order 1-25


    //giuocob 19-2-13: bingoBoard is no longer populated left to right:
    //It is now populated mostly randomly, with high difficult goals and
    //goals on the diagonals out in front
    var populationOrder = [];
    populationOrder[1] = 13;   //Populate center first
    var diagonals = [1,7,19,25,5,9,17,21];
    shuffle(diagonals);
    populationOrder = populationOrder.concat(diagonals);   //Next populate diagonals
    var nondiagonals = [2,3,4,6,8,10,11,12,14,15,16,18,20,22,23,24];
    shuffle(nondiagonals);
    populationOrder = populationOrder.concat(nondiagonals);   //Finally add the rest of the squares
    //Lastly, find location of difficulty 23,24,25 elements and put them out front
    for(var k=23; k <= 25; k++) {
      var currentSquare = getDifficultyIndex(k);
      if(currentSquare == 0) continue;
      for(var i=1; i < 25; i++) {
        if(populationOrder[i] == currentSquare) {
          populationOrder.splice(i,1);
          break;
        }
      }
      populationOrder.splice(1,0,currentSquare);
    }



    //Populate the bingo board in the array
    //giuocob 16-8-12: changed this section to:
    //1. Support uniform goal selection by shuffling arrays before checking goals
    //2. Remove all child rows by checking child tag
    //3. If no goal is suitable, instead of choosing goal with lowest synergy, now next difficulty up is checked
    for(var i=1; i <= 25; i++) {
      var sq = populationOrder[i];
      var getDifficulty = bingoBoard[sq].difficulty;
      var goalArray = getShuffledGoals(bingoList, getDifficulty);
      var j=0, synergy=0, currentObj=null, minSynObj=null;

      do {
        currentObj = goalArray[j];
        synergy = checkLine(sq,currentObj);
        if(minSynObj == null || synergy < minSynObj.synergy) {
          minSynObj = {synergy: synergy, value: currentObj};
        }
        j++;
        if(j >= goalArray.length) {
          getDifficulty++;
          if(getDifficulty > 25) break;
          else {
            goalArray = getShuffledGoals(bingoList, getDifficulty);
            j = 0;
          }
        }
      } while(synergy != 0);   //Perhaps increase to 1 if difficulty increases happen too often


      bingoBoard[sq].types = minSynObj.value.types;
      bingoBoard[sq].boardtypes = minSynObj.value.boardtypes;
      bingoBoard[sq].name = minSynObj.value[lang] || minSynObj.value.name;
      bingoBoard[sq].child = minSynObj.value.child;
      bingoBoard[sq].synergy = minSynObj.synergy;
    }

    // 1-indexing is bad.
    bingoBoard.shift();
    return bingoBoard;
}
