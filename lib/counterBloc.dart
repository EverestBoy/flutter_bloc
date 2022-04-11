import 'dart:async';

enum CounterAction {
  Increment,
  Decrement,
  Reset
}

class CounterBloc {

  int counter = 0;

  // sink for the text widget
  final _stateStreamContoller = StreamController<int>();
  StreamSink<int> get _counterSink => _stateStreamContoller.sink;
  Stream<int> get counterStream => _stateStreamContoller.stream;

  // stream for button event
  final _eventStreamController = StreamController<CounterAction>();
  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  Stream<CounterAction> get _eventStream => _eventStreamController.stream;

  // constructor
  CounterBloc(){
    counter = 0;
    _eventStream.listen((event) {
      if(event == CounterAction.Increment) counter++;
      else if(event == CounterAction.Decrement) counter--;
      else if(event == CounterAction.Reset) counter=0;
      _counterSink.add(counter);
    });

  }

  void dispose(){
    _eventStreamController.close();
    _stateStreamContoller.close();
  }

}