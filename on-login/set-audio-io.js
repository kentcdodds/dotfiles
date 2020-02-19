const {execSync} = require('child_process')

const inputPreferences = ['USB AUDIO  CODEC', 'MacBook Pro Microphone']

const outputPreferences = [
  'OWC Thunderbolt 3 Audio Device',
  'MacBook Pro Speakers',
]

const options = execSync('SwitchAudioSource -a')
  .toString()
  .trim()
  .split('\n')
  .reduce(
    (opts, line) => {
      if (line.includes(' (input)')) {
        opts.inputs.push(line.replace(' (input)', ''))
      } else if (line.includes(' (output)')) {
        opts.outputs.push(line.replace(' (output)', ''))
      } else {
        console.warn('Line does not include input or output...')
      }
      return opts
    },
    {inputs: [], outputs: []},
  )

const inputPreference = inputPreferences.find(pref =>
  options.inputs.includes(pref),
)
if (inputPreference) {
  try {
    execSync(`SwitchAudioSource -t input -s "${inputPreference}"`)
  } catch (error) {
    // ignore the error. We tried our best
  }
}

const outputPreference = outputPreferences.find(pref =>
  options.outputs.includes(pref),
)
if (outputPreference) {
  try {
    execSync(`SwitchAudioSource -t output -s "${outputPreference}"`)
  } catch (error) {
    // ignore the error. We tried our best
  }
}
