import { NativeModule, Platform, requireNativeModule } from 'expo-modules-core';

import { Contact as ContactType } from './types/Contact';
import { Container as ContainerType, FallbackContainer } from './types/Container';
import { Group as GroupType, FallbackGroup } from './types/Group';
import { ContactsPermissionResponse } from './types/Permissions';

declare class ExpoContactsModule extends NativeModule {
  ContactNext?: typeof ContactType;
  Contact: typeof ContactType;
  Group: typeof GroupType;
  Container: typeof ContainerType;
  getPermissionsAsync(): Promise<ContactsPermissionResponse>;
  requestPermissionsAsync(): Promise<ContactsPermissionResponse>;
}

const expoContactsModule = requireNativeModule<ExpoContactsModule>('ExpoContactsNext');

if (Platform.OS === 'ios' && expoContactsModule.ContactNext) {
  expoContactsModule.Contact = expoContactsModule.ContactNext;
}

/**
 * Represents a contact in the device's address book.
 *
 * - Data Retrieval:
 * Contact details can be accessed using the `getDetails` method
 * or via specific getters such as `getEmails` and `getPhones`.
 *
 * - Modification:
 * To update the contact, use bulk operations via `patch` or `update`,
 * or specific modifiers like `addEmail` and `deletePhone`.
 * @example
 * ```ts
 * const contact = await Contact.create({
 *    givenName: 'John',
 *    familyName: 'Doe',
 *    phones: [{ label: 'mobile', number: '+12123456789' }]
 * });
 * ```
 */
export class Contact extends expoContactsModule.Contact {}

/**
 * Represents a group of contacts (for example, "Family", "Coworkers").
 * Groups belong to a specific Container and can contain multiple Contacts.
 * @platform ios
 */
export class Group extends (expoContactsModule.Group || FallbackGroup) {}

/**
 * Represents a container for contacts.
 * A container (often called an "Account" in UI terms) is a source of contacts, such as a local device storage, iCloud, Google, or Exchange account.
 * @platform ios
 */
export class Container extends (expoContactsModule.Container || FallbackContainer) {}

/**
 * Checks user's permissions for accessing contacts data.
 * @returns A promise that resolves to a [`ContactsPermissionResponse`](#contactspermissionresponse) object.
 */
export async function getPermissionsAsync() {
  return expoContactsModule.getPermissionsAsync();
}

/**
 * Asks the user to grant permissions for accessing contacts data.
 * @returns A promise that resolves to a [`ContactsPermissionResponse`](#contactspermissionresponse) object.
 */
export async function requestPermissionsAsync() {
  return expoContactsModule.requestPermissionsAsync();
}
