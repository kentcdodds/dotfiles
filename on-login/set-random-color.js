const {execSync} = require('child_process')

const colors = {
  blue: {},
  gray: {highlight: '0.847059 0.847059 0.862745 Graphite', accent: -1},
  red: {highlight: '1.000000 0.733333 0.721569 Red', accent: 0},
  orange: {highlight: '1.000000 0.874510 0.701961 Orange', accent: 1},
  yellow: {highlight: '1.000000 0.937255 0.690196 Yellow', accent: 2},
  green: {highlight: '0.752941 0.964706 0.678431 Green', accent: 3},
  purple: {highlight: '0.968627 0.831373 1.000000 Purple', accent: 5},
  pink: {highlight: '1.000000 0.749020 0.823529 Pink', accent: 6},
}

const color = random(Object.keys(colors))
console.log(`Setting accent and highlight color to ${color}`)
const {accent, highlight} = colors[color]

if (accent === undefined) {
  try {
    execSync(`defaults delete NSGlobalDomain AppleAccentColor`)
  } catch (error) {
    // it's possible we deleted it already so we'll ignore this error
  }
} else {
  execSync(`defaults write NSGlobalDomain AppleAccentColor -integer ${accent}`)
}

if (highlight === undefined) {
  try {
    execSync(`defaults delete NSGlobalDomain AppleHighlightColor`)
  } catch (error) {
    // it's possible we deleted it already so we'll ignore this error
  }
} else {
  execSync(
    `defaults write NSGlobalDomain AppleHighlightColor -string "${highlight}"`,
  )
}

// send notification that preferences have changed
execSync(`sendevent AppleColorPreferencesChangedNotification`)

function random(array) {
  return array[Math.floor(Math.random() * array.length)]
}
