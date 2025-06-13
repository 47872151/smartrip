import react from 'react';
import { View, Text, StyleSheet } from 'react-native';

const Stepper = ({ steps = 3, currentStep = 1 }) => {
  return (
    <View style={styles.container}>
      {[...Array(steps)].map((_, i) => {
        const step = i + 1;
        const isActive = step === currentStep;
        const isCompleted = step < currentStep;

        return (
          <View key={step} style={styles.stepContainer}>
            <View
              style={[
                styles.circle,
                isActive ? styles.activeCircle : isCompleted ? styles.completedCircle : null,
              ]}
            >
              <Text style={[styles.stepText, isActive || isCompleted ? styles.activeText : null]}>
                {step}
              </Text>
            </View>
            {step < steps && (
              <View
                style={[
                  styles.line,
                  isCompleted ? styles.activeLine : styles.inactiveLine,
                ]}
              />
            )}
          </View>
        );
      })}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    marginTop: 5,
    marginBottom: 15,
  },
  stepContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  circle: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: '#e5e7eb', // gris claro
    justifyContent: 'center',
    alignItems: 'center',
  },
  activeCircle: {
    backgroundColor: '#00bcd4', // celeste
  },
  completedCircle: {
    backgroundColor: '#e5e7eb',
  },
  stepText: {
    color: '#000',
    fontWeight: 'bold',
  },
  activeText: {
    color: '#fff',
  },
  line: {
    width: 40,
    height: 2,
    marginHorizontal: 4,
  },
  activeLine: {
    backgroundColor: '#e5e7eb',
  },
  inactiveLine: {
    backgroundColor: '#e5e7eb',
  },
});

export default Stepper;
