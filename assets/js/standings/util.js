export function renderJoined(children, render, renderSeparator) {
  return children.reduce((result, child, index) => {
    if (index < children.length - 1) {
      return result.concat([render(child, index), renderSeparator(index + '-separator')])
    }

    return result.concat(render(child, index))
  }, []);
}


const TEAM_COLORS = {
  "#6fa56b": "green",
  "#f0c566": "yellow",
  "#df9753": "orange",
  "#dd8eb4": "pink",
  "#56a3d8": "blue",
  "#d46060": "red",
  "#979c9f": "grey",
  "#8c5eac": "purple"
}

export function teamColorName(hexcode) {
  return TEAM_COLORS[hexcode];
}
