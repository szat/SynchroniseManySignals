# SynchroniseManySignals
A simple algorithm based on xcorr and a recurrence relation to synchronise many signals simultaneously. Big O in number of signals. 

## Getting Started

This code return bounds rather than not offsets, so that for each signal we have different window where the start corresponds to the start of every other signal and the end corresponds to the end of every other signal. As such this can be readily used for smart cropping audio signals, and hence movies. Moreover any point within this window is synchronized with the other signals, therefore one can get back the offset. 

The main idea behind the algorithm is that each pairwise cropping (syncing) should restrict the cropping of all signals, so that the next pairwise cropping is done with the previously cropped signal and the next signal. Therefore, the information of all the previous signals is propagated. 

### Prerequisites

For this to run you need Matlab installed, along these toolboxes:
	-signal_toolbox

## Author

Adrian Szatmari 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details