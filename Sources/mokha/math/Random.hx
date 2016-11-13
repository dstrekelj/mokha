package mokha.math;

import kha.math.Random;

/**
    This class is a wrapper around Kha's `Random` class that provides
    additional functionality, such as returning random boolean or
    signed values. Best used as a single, reused instance.
**/
class Random {
    /**
        Internal reference to Kha's pseudorandom number generator.
    **/
    var random : kha.math.Random;

    /**
        Creates new pseudorandom number generator.
        @param  seed    Number generation seed, defaults to 1
    **/
    public function new(?seed : Int = 1) : Void {
        this.random = new kha.math.Random(seed);
    }

    /**
        Returns a pseudorandom boolean state. Probability is expected
        to be in range [0, 1].
        @param  probability Probability of `true`, defaults to 0.5
    **/
    public inline function bool(probability : Float = 0.5) : Bool {
        return probability > floatIn(0, 1);
    }

    /**
        Returns a pseudorandom floating point value.
    **/
    public inline function float() : Float {
        return random.GetFloat();
    }

    /**
        Returns a pseudorandom floating point value in [min, max]
        range.
        @param  min Smallest possible number, included
        @param  max Largest possible number, included
    **/
    public inline function floatIn(min : Float, max : Float) : Float {
        return random.GetFloatIn(min, max);
    }

    /**
        Returns a pseudorandom floating point value in [0, max] range.
        @param max Largest possible number, included
    **/
    public inline function floatUpTo(max : Float) : Float {
        return floatIn(0, max);
    }

    /**
        Returns a pseudorandom integer.
    **/
    public inline function int() : Int {
        return random.Get();
    }

    /**
        Returns a pseudorandom integer in range [min, max].
        @param  min Smallest possible number, included
        @param  max Largest possible number, included
    **/
    public inline function intIn(min : Int, max : Int) : Int {
        return random.GetIn(min, max);
    }

    /**
        Returns a pseudorandom integer in range [0, max].
        @param  max Largest possible number, included
    **/
    public inline function intUpTo(max : Int) : Int {
        return random.GetUpTo(max);
    }

    /**
        Returns a pseudorandom sign (-1 or 1). Probability is expected
        to be in range [0, 1].
        @param  probability Probability of sign (-1), defaults to 0.5
    **/
    public inline function sign(probability : Float = 0.5) : Int {
        return bool(probability) ? -1 : 1;
    }

    /**
        For an array of weights (probabilities), returns the index of
        the element whose weight was picked. For optimal results, the
        sum of all weights should equal 1.
        @param  weights An array of weights in range [0, 1]
    **/
    public function weightedPick(weights : Array<Float>) : Int {
        var weightSum = 0.0;
        for (weight in weights) weightSum += weight;

        var roll = floatUpTo(weightSum);
        for (i in 0...weights.length) {
            if (weights[i] > roll) return i;
            roll -= weights[i];
        }

        return 0;
    }
}
