import { ConfigContext, ExpoConfig } from '@expo/config';
import 'tsx/cjs';

const config = ({ config }: ConfigContext): ExpoConfig => ({
  ...config,
  name: 'Observe',
  slug: 'observability',
  extra: {
    ...config.extra,
    eas: {
      ...config.extra?.eas,
      observe: {
        enableInDebug: true,
        endpointUrl: 'http://localhost:3003/',
      },
    },
  },
});

export default config;
